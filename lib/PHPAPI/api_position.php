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
 
 
/*
        $position = array(
            'datetime' => $datetime, 
            'lat' => $lat, 
            'long' => $long
        );

            $name = array(
                'name' => $name,
                'position' => $position
            );
*/
        $txt = json_encode($ParsedAry);
        fwrite($myfile, $txt);
        fclose($myfile);
        echo "Chiamata riuscita";
    }

    if ($getset == 'get'){
        $i=0;
        $response = [];
        foreach (glob("*.json") as $fileinfo) {  //fileinfo contiene il filename

            $json = file_get_contents($fileinfo); 

            // Check if the file was read successfully
            if ($json === false) {
                die('Error reading the JSON file');
            }

            $obj = json_decode($json, TRUE);

            // Check if the JSON was decoded successfully
            if ($obj === null) {
                die('Error decoding the JSON file');
            }

            $response[$i] = $obj;
            $i++;
        // Display data
    }
    echo json_encode($response);
//echo $response;
//print_r($response);
    }
}
else {
        echo "Wrong api key";
     }

?>

