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
    $username = $_POST["username"];
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
  
   
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        $sql = "SELECT * FROM users WHERE username = '$username';";
        
    
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        $count = mysql_num_rows($retval);
        if ($count > 0 )
        {
             $result = mysql_fetch_assoc($retval);
            //echo "this is the result \n";
           // echo $result;
            $result = json_encode($result, JSON_NUMERIC_CHECK);
            echo $result;
           
        }
        else
        {
           
            echo "User doesn't exist";
        }
       
        
     
       
      
  
    }
    
    
    
   
    
    
    
    
    
    
    
    ?>
