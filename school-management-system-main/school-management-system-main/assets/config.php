<?php
    $server = "127.0.0.1";
   
    $user = "sms_user";
    $password = "";
    $db = "_sms";
    
    $conn = mysqli_connect($server, $user, $password, $db);

    if (!$conn) {
        header('Location: ../errors/error.html');
        exit();
    }


?>