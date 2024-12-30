<?php
$key=$_POST['apikey'];
$getset=$_POST['getset'];

if ($key=='IDDKFA'){
    if ($getset == 'set'){
        $name=$_POST['name'];
        $datetime=date("Y-m-d H:i:s");
        $lat=$_POST['lat'];
        $long=$_POST['long'];

        $postdata = file_get_contents("php://input");

        unlink($name.".json");
        $myfile = fopen($name.".json", "w") or die("Unable to open file!");


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

    if ($getset == 'get'){
        $i=0;
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

            $response[$i] = $obj;
            $i++;
    }
    echo json_encode($response);
    }
}
elseif ($key=='LMFAO'){
    foreach (glob("*.json") as $filename) {
       unlink($filename);
    }
}
else {
        echo "Wrong api key";
     }

?>

