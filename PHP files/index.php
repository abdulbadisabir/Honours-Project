<?php
   // phpinfo();
   // $obj = json_decode(file_get_contents('php://input'),TRUE);
    $configs = include('config.php');
   
    
    $servername = $configs["host"];
    $username = $configs["username"];
    $password = $configs["password"];
    $dbname = $configs["dbname"];
    
   
    
    
    $conn = new mysqli($servername, $username, $password, $dbname);
    
    $username = $_POST["username"];
    $password = $_POST["password"];

    echo "shouldv";
    
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        echo "sup";
        $sql = "INSERT INTO users (username,password) VALUES ('$username','$password')";
     
        echo "$password";
        echo "$username";
        $conn->query($sql);
        
        echo "IT kinda WORKEDeeed!!";
    }
    
    
    
    /*
    $sql = "SELECT name FROM userinfo WHERE id=1";
    $result = $conn->query($sql);
    
    echo $result->name;
    
   
    
    if($conn->query($sql) == TRUE){
        echo "it worked and ";
        echo $result;
    }else
    {
        echo "it didn't work";
    }*/
    
    
    
    
    
    
    
    ?>
