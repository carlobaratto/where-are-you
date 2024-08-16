<?php
$key=$_POST['apikey'];
$name=$_POST['name'];
$datetime=date("Y-m-d H:i:s");
$lat=$_POST['lat'];
$long=$_POST['long'];

$postdata = file_get_contents("php://input");
if (isset($postdata) && $key=='IDDKFA') {
    unlink($name.".json");
    $myfile = fopen($name.".json", "w") or die("Unable to open file!");
    $txt = "datetime:".$datetime."\n";
    fwrite($myfile, $txt);
    $txt = "lat:".$lat."\n";
    fwrite($myfile, $txt);
    $txt = "long:".$long."\n";
    fwrite($myfile, $txt);
    fclose($myfile);
    echo "Chiamata riuscita";
    echo $name;
}
else {
    echo "Wrong api key";
}
?>
