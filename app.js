
const API_URL = 'api.php';

function sparkSvg(size, color) {
    return `<svg width="${size}" height="${size}" viewBox="0 0 24 24">
        <path d="M12 0 L14.5 9.5 L24 12 L14.5 14.5 L12 24 L9.5 14.5 L0 12 L9.5 9.5 Z" fill="${color}" />
    </svg>`;
}

function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str ?? '';
    return div.innerHTML;
}

function setText(id, value) {
    const el = document.getElementById(id);
    if (el) el.textContent = value ?? '';
}

// ---------------------------------------------------------------------
// Render-functies per onderdeel van de app
// ---------------------------------------------------------------------

function renderContentTexts(content) {
    setText('brandTitle', content.brand_title);
    setText('brandSub', content.brand_sub);

    setText('heroEyebrow', content.hero_eyebrow);
    setText('heroTitle', content.hero_title);
    setText('heroDesc', content.hero_desc);
    document.getElementById('stampInner').innerHTML =
        `${escapeHtml(content.stamp_line1)}<br>${escapeHtml(content.stamp_line2)}`;

    setText('whyHeading', content.why_heading);
    setText('whyText', content.why_text);
    setText('quickNavHeading', content.label_quicknav);

    setText('noteActivities', content.note_activities);
    setText('notePractical', content.note_practical);

    setText('headingMap', content.heading_map);
    setText('headingHeenreis', content.heading_heenreis);
    setText('headingOv', content.heading_ov);
    setText('headingEmergency', content.heading_emergency);
    setText('headingKnow', content.heading_know);

    setText('navHome', content.nav_home);
    setText('navSights', content.nav_sights);
    setText('navActivities', content.nav_activities);
    setText('navPractical', content.nav_practical);

    const mapFrame = document.getElementById('mapFrame');
    mapFrame.src = content.map_embed_url || '';
    const mapLink = document.getElementById('mapLink');
    mapLink.href = content.map_link_url || '#';
    mapLink.textContent = content.map_link_label || '';
}

function renderFacts(facts) {
    const wrap = document.getElementById('factsStrip');
    wrap.innerHTML = facts.map(f => `
        <div class="fact-card">
            <div class="fact-label">${escapeHtml(f.label)}</div>
            <div class="fact-value">${escapeHtml(f.value)}</div>
        </div>
    `).join('');
}

function renderShortcuts(shortcuts) {
    const wrap = document.getElementById('shortcutGrid');
    wrap.innerHTML = shortcuts.map(s => `
        <button class="shortcut" onclick="goTo('${escapeHtml(s.target_view)}')" ${s.full_width == 1 ? 'style="grid-column:1 / -1;"' : ''}>
            <span class="spark">${sparkSvg(16, '#160029')}</span>
            <div class="sc-title">${escapeHtml(s.title)}</div>
            <div class="sc-sub">${escapeHtml(s.subtitle)}</div>
        </button>
    `).join('');
}

function renderItemCards(containerId, items) {
    const wrap = document.getElementById(containerId);
    wrap.innerHTML = items.map(item => `
        <div class="item-card">
            <div class="item-icon">${sparkSvg(20, item.icon_color)}</div>
            <div class="item-body">
                <div class="item-top">
                    <div class="item-title">${escapeHtml(item.title)}</div><span class="tag">${escapeHtml(item.tag)}</span>
                </div>
                <p class="item-desc">${escapeHtml(item.description)}</p>
                <div class="item-tip"><span class="tip-label">TIP</span> ${escapeHtml(item.tip)}</div>
            </div>
        </div>
    `).join('');
}

function renderInfoList(containerId, lines) {
    const wrap = document.getElementById(containerId);
    wrap.innerHTML = lines.map(line => `
        <li><span class="spark">${sparkSvg(12, '#D44D5C')}</span>${escapeHtml(line)}</li>
    `).join('');
}

function renderTransit(transit) {
    const wrap = document.getElementById('transitRows');
    wrap.innerHTML = transit.map(t => `
        <div class="transit-row">
            <div class="line-badge ${escapeHtml(t.badge_class)}">${escapeHtml(t.badge_text)}</div>
            <div class="transit-text"><b>${escapeHtml(t.title)}</b> — ${escapeHtml(t.description)}</div>
        </div>
    `).join('');
}

function renderEmergency(contacts) {
    const wrap = document.getElementById('emergencyCard');
    wrap.innerHTML = contacts.map(c => `
        <div class="emergency-row">
            <span class="emergency-name">${escapeHtml(c.name)}</span>
            <span class="emergency-num">${escapeHtml(c.number)}</span>
        </div>
    `).join('');
}

function renderAll(data) {
    renderContentTexts(data.content);
    renderFacts(data.facts);
    renderShortcuts(data.shortcuts);
    renderItemCards('sightsList', data.sights);
    renderItemCards('activitiesList', data.activities);
    renderTransit(data.transit);
    renderInfoList('heenreisList', data.info.heenreis || []);
    renderInfoList('ovTicketsList', data.info.ov_tickets || []);
    renderInfoList('knowList', data.info.goed_om_te_weten || []);
    renderEmergency(data.emergency);

    // labels object voor de paginatitel bovenin, gebruikt door goTo()
    window.__viewLabels = {
        home: { label: data.content.label_home, title: data.content.title_home },
        sights: { label: data.content.label_sights, title: data.content.title_sights },
        activities: { label: data.content.label_activities, title: data.content.title_activities },
        practical: { label: data.content.label_practical, title: data.content.title_practical },
    };
    goTo(window.__currentView || 'home');
}

function showStatus(message, isError) {
    const banner = document.getElementById('statusBanner');
    if (!message) {
        banner.hidden = true;
        return;
    }
    banner.hidden = false;
    banner.textContent = message;
    banner.classList.toggle('status-banner--error', !!isError);
}

// ---------------------------------------------------------------------
// Navigatie tussen de 4 views (zelfde gedrag als voorheen)
// ---------------------------------------------------------------------
function goTo(view) {
    window.__currentView = view;

    document.querySelectorAll('.view').forEach(v => v.classList.remove('active'));
    document.getElementById('view-' + view).classList.add('active');

    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    document.querySelector('.nav-btn[data-view="' + view + '"]').classList.add('active');

    const labels = window.__viewLabels;
    if (labels && labels[view]) {
        setText('pageLabel', labels[view].label);
        setText('pageTitle', labels[view].title);
    }

    document.querySelector('.app-content').scrollTo({ top: 0, behavior: 'instant' });
}

// ---------------------------------------------------------------------
// Data ophalen bij api.php (dat leest de MySQL-database uit)
// ---------------------------------------------------------------------
async function loadData() {
    try {
        const res = await fetch(API_URL, { cache: 'no-store' });
        if (!res.ok) throw new Error('API gaf status ' + res.status);
        const data = await res.json();
        if (data.error) throw new Error(data.error);

        renderAll(data);
        showStatus(null);
    } catch (err) {
        console.error('Kon data niet laden:', err);
        showStatus(
            navigator.onLine
                ? 'Kon geen verbinding maken met de database. Controleer db/config.php en of de database geïmporteerd is.'
                : 'Je bent offline — laatst opgeslagen gegevens worden getoond zodra beschikbaar.',
            true
        );
    }
}

document.addEventListener('DOMContentLoaded', loadData);
window.addEventListener('online', loadData);

// ---------------------------------------------------------------------
// Service worker registreren (maakt de app installeerbaar + offline bruikbaar)
// ---------------------------------------------------------------------
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('sw.js').catch(err => {
            console.warn('Service worker registratie mislukt:', err);
        });
    });
}
