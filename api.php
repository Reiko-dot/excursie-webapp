<?php


require_once __DIR__ . '/db/config.php';

header('Content-Type: application/json; charset=utf-8');
// Laat de browser/service worker het antwoord kort cachen als "vers genoeg"
header('Cache-Control: public, max-age=60');

$pdo = get_db_connection();

try {
    // ---- site_content (key/value) -> platte object ----
    $stmt = $pdo->query('SELECT content_key, content_value FROM exc_site_content');
    $content = [];
    foreach ($stmt->fetchAll() as $row) {
        $content[$row['content_key']] = $row['content_value'];
    }

    // ---- quick facts ----
    $facts = $pdo->query(
        'SELECT label, value FROM exc_quick_facts ORDER BY sort_order ASC'
    )->fetchAll();

    // ---- shortcuts ----
    $shortcuts = $pdo->query(
        'SELECT target_view, title, subtitle, full_width FROM exc_shortcuts ORDER BY sort_order ASC'
    )->fetchAll();

    // ---- items: sights + activities ----
    $itemsStmt = $pdo->query(
        'SELECT category, title, tag, description, tip, icon_color
         FROM exc_items ORDER BY category ASC, sort_order ASC'
    );
    $sights = [];
    $activities = [];
    foreach ($itemsStmt->fetchAll() as $row) {
        if ($row['category'] === 'sight') {
            $sights[] = $row;
        } else {
            $activities[] = $row;
        }
    }

    // ---- transit lines ----
    $transit = $pdo->query(
        'SELECT badge_text, badge_class, title, description FROM exc_transit_lines ORDER BY sort_order ASC'
    )->fetchAll();

    // ---- info lists, gegroepeerd per sectie ----
    $infoStmt = $pdo->query(
        'SELECT section, content FROM exc_info_lists ORDER BY section ASC, sort_order ASC'
    );
    $info = ['heenreis' => [], 'ov_tickets' => [], 'goed_om_te_weten' => []];
    foreach ($infoStmt->fetchAll() as $row) {
        $info[$row['section']][] = $row['content'];
    }

    // ---- noodnummers ----
    $emergency = $pdo->query(
        'SELECT name, number FROM exc_emergency_contacts ORDER BY sort_order ASC'
    )->fetchAll();

    echo json_encode([
        'content'    => $content,
        'facts'      => $facts,
        'shortcuts'  => $shortcuts,
        'sights'     => $sights,
        'activities' => $activities,
        'transit'    => $transit,
        'info'       => $info,
        'emergency'  => $emergency,
    ], JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Databasefout bij ophalen van content.']);
}
