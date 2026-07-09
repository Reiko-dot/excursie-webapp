<?php

define('DB_HOST', 'localhost');
define('DB_NAME', 'excursie_database');
define('DB_USER', 'jouw_db_gebruiker');
define('DB_PASS', 'jouw_db_wachtwoord');

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
                'error' => 'Kan geen verbinding maken met de database. Controleer db/config.php.',
            ]);
            exit;
        }
    }

    return $pdo;
}
