<?php

require 'vendor/autoload.php';

include 'config.inc.php';

use Doctrine\DBAL\DriverManager;
use Doctrine\DBAL\Exception;

try{
    $config = DriverManager::getConnection([
        'driver' => 'pdo_sqlite',
        'path' => $dbFile
    ]);
} catch (Exception $e) {
    die("Could not connect to database: " . $e->getMessage());
}

$key    = $_POST['apikey'];
$getset = $_POST['getset'];

$group  = $_POST['group'];
$name   = $_POST['name'];
$lat    = $_POST['lat'];
$lon    = $_POST['long'];

if ($key != $user_api_key) {
    die( json_encode([
        'status' => 401,
        'message' => 'Invalid user API key'
    ]) );
}

// Creazione della tabella se non esiste
try {
    $config->executeQuery("CREATE TABLE IF NOT EXISTS user_locations (
        `id` INTEGER PRIMARY KEY AUTOINCREMENT,
        `group` TEXT NULL,
        `name` TEXT NULL,
        `datetime` TEXT NOT NULL,
        `lat` REAL NOT NULL,
        `lon` REAL NOT NULL
    )");
} catch (Exception $e) {
    die("Could not create table: " . $e->getMessage());
}

if ($getset == 'set') {
    // Sanitize user name
    $name = mb_ereg_replace("([^\w\s\d\-_~,;$$$$$$.])", '', $name);
    $datetime = date("Y-m-d H:i:s");

    // Inserimento dei dati nel database
    try{
        $config->insert('user_locations', [
            '`group`' => $group,
            'name' => $name,
            'datetime' => $datetime,
            'lat' => $lat,
            'lon' => $lon
        ]);

        echo json_encode([
            'status' => 200
        ]);
    } catch (Exception $e) {
        echo json_encode([
            'status' => 500,
            'message' => 'Could not insert data: ' . $e->getMessage()
        ]);
    }
}

elseif ($getset == 'get') {
    $response = [];
    $stmt = $config->executeQuery("SELECT * FROM user_locations WHERE `group` = ?", [$group]);
    while ($row = $stmt->fetchAssociative()) {
        $lastseen = $row['datetime'];
        $d1 = new DateTime($lastseen);
        $d2 = new DateTime();
        $interval = $d2->diff($d1);
        $minutes = ($interval->days * 24 * 60) + ($interval->h * 60) + $interval->i;
        $row['minutes'] = $minutes;

        if ($minutes < 10) {
            $row['color'] = 'green';
        } elseif ($minutes >= 10 && $minutes <= 60) {
            $row['color'] = 'orange';
        } else {
            $row['color'] = 'grey';
        }

        // Rimozione dei dati di geolocalizzazione dopo N minuti
        if ($minutes > $max_minutes_to_keep) {
            $config->delete('user_locations', ['id' => $row['id']]);
        }

        $response[] = $row;
    }
    echo json_encode($response);

} else {
    echo json_encode([
        'status' => 400,
        'message' => 'Invalid request'
    ]);
}
