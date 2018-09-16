<?php
   // phpinfo();
   // $obj = json_decode(file_get_contents('php://input'),TRUE);
    $configs = include('config.php');
   
    
    $servername = $configs["host"];
    $username = $configs["username"];
    $password = $configs["password"];
    $dbname = $configs["dbname"];
    
   
    
    
    $conn = mysql_connect($servername, $username, $password);
     mysql_select_db($dbname);
   // $_POST = json_decode(file_get_contents('php://input'), true);
    $username = $_POST["username"];
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }

  
    
    if ($conn->connect_error) {
         echo "An error occurred!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        $sql = "SELECT * FROM users WHERE username = '$username' ";
        //$sql = "INSERT INTO users (username,password) VALUES ('hihihi','bbb')";
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        
        $count = mysql_num_rows($retval);
        if ($count > 0)
        {
            echo "true";
        }
        else
        {
            echo "false";
        }
       
     
       
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
