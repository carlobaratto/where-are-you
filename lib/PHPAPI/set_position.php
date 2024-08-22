<?php
$key=$_POST['apikey'];
$name=$_POST['name'];
$datetime=date("Y-m-d H:i:s");
$lat=$_POST['lat'];
$long=$_POST['long'];

//https://stackoverflow.com/questions/15485354/angular-http-post-to-php-and-undefined
$postdata = file_get_contents("php://input");
if (isset($postdata) && $key=='IDDKFA') {
    unlink($name.".json");
    $myfile = fopen($name.".json", "w") or die("Unable to open file!");
    $data = array(
                    'datetime' => $datetime, 
                    'lat' => $lat, 
                    'long' => $long
                );

    $txt = json_encode($data);
    fwrite($myfile, $txt);
    fclose($myfile);
    echo "Chiamata riuscita";
}
else {
    echo "Wrong api key";
}
?>
