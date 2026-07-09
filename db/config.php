<?php


define('DB_HOST', 'localhost');
define('DB_NAME', 'u240761_excursie_db_de');
define('DB_USER', 'u240761_excursie_db_de');
define('DB_PASS', 'rDHc5xzaDWcdJh3LpRzu');


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
