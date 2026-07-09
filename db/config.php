<?php
/**
 * Database-configuratie.
 * Vul deze 4 waardes in met de gegevens van jouw hosting (zelfde soort
 * gegevens als je bij een WordPress wp-config.php invult).
 *
 * Lokaal (XAMPP/Laragon): standaard user 'root' met LEEG wachtwoord.
 * MAMP: wachtwoord is meestal 'root' i.p.v. leeg, soms host '127.0.0.1'
 * met poort 8889 i.p.v. 'localhost'.
 */

define('DB_HOST', 'localhost');
define('DB_NAME', 'excursie_database');
define('DB_USER', 'root');
define('DB_PASS', '');

// Zet dit tijdelijk op true als je wilt zien wát er precies misgaat
// (bijv. verkeerd wachtwoord, database bestaat niet). Zet 'm op false
// zodra alles werkt of als de site live staat — anders kan iedereen
// je database-foutmeldingen zien.
define('DB_DEBUG', true);

function get_db_connection(): PDO {
    static $pdo = null;

    if ($pdo === null) {
        $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4';
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];

        try {
            $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        } catch (PDOException $e) {
            http_response_code(500);
            header('Content-Type: application/json');
            echo json_encode([
                'error' => DB_DEBUG
                    ? 'Databaseverbinding mislukt: ' . $e->getMessage()
                    : 'Kan geen verbinding maken met de database. Controleer db/config.php.',
            ]);
            exit;
        }
    }

    return $pdo;
}
