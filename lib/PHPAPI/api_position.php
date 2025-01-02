<?php

include 'config.inc.php';

$key = $_POST['apikey'];
$getset = $_POST['getset'];

if ($key == $user_api_key) {
    if ($getset == 'set') {
        // Sanitize user name
        $name = mb_ereg_replace("([^\w\s\d\-_~,;\[\]\(\).])", '', $_POST['name']);
        $datetime = date("Y-m-d H:i:s");
        $lat = $_POST['lat'];
        $long = $_POST['long'];

        $postdata = file_get_contents("php://input");

        unlink($name . ".json");
        $myfile = fopen($name . ".json", "w") or die("Unable to open file!");


        $ParsedAry = [
            "name" => $name,
            "datetime" => $datetime,
            'lat' => $lat,
            'long' => $long
        ];

        $txt = json_encode($ParsedAry);
        fwrite($myfile, $txt);
        fclose($myfile);
    }

    if ($getset == 'get') {
        $i = 0;
        $response = [];
        foreach (glob("*.json") as $fileinfo) {

            $json = file_get_contents($fileinfo);

            if ($json === false) {
                die('Error reading the JSON file');
            }

            $obj = json_decode($json, TRUE);

            if ($obj === null) {
                die('Error decoding the JSON file');
            }

            $lastseen = $obj['datetime'];
            $diff = date_diff(date(), strtotime($lastseen));

            $d1= new DateTime($obj['datetime']); // lasteseen
            $d2= new DateTime(); // today
            $interval = $d2->diff($d1);
            $minutes = ($interval->days * 24 * 60) + ($interval->h * 60) + $interval->i;
            $obj['minutes']= $minutes;

            if ($minutes<10) {
                $obj['color']= 'green';
            }

            if ($minutes>=10) {
                $obj['color']= 'orange';
            }

            if ($minutes>60) {
                $obj['color']= 'grey';
            }

            $response[$i] = $obj;

            $i++;
        }
        echo json_encode($response);
    }
} elseif ($key == $admin_api_key) {
    foreach (glob("*.json") as $filename) {
        unlink($filename);
    }
} else {
    echo "Wrong api key";
}
