<?php
$key=$_GET['apikey'];


//https://stackoverflow.com/questions/15485354/angular-http-post-to-php-and-undefined
$postdata = file_get_contents("php://input");
if (isset($postdata) && $key=='IDDKFA') {

    //$dir = new DirectoryIterator(dirname(__FILE__));
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
    //}
}
else {
  echo "Wrong api key";
}
?>

