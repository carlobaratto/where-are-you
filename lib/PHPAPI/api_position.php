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
        $data = array(
                        'name' => $name,
                        'datetime' => $datetime, 
                        'lat' => $lat, 
                        'long' => $long
                    );

        $txt = json_encode($data);
        fwrite($myfile, $txt);
        fclose($myfile);
        echo "Chiamata riuscita";
    }
    if ($getset == 'get'){
        foreach (glob("*.json") as $fileinfo) {  //fileinfo contiene il filename

            $json = file_get_contents($fileinfo); 

            
            // Check if the file was read successfully
            if ($json === false) {
                die('Error reading the JSON file');
            }

            // Decode the JSON file
            $json_data .= $json; 

            // Check if the JSON was decoded successfully
            if ($json_data === null) {
                die('Error decoding the JSON file');
            }

        // Display data
        echo $json_data;
      
    }
}
else {
        echo "Wrong api key";
     }
}
?>

