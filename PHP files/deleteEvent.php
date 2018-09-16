<?php
   // phpinfo();
   // $obj = json_decode(file_get_contents('php://input'),TRUE);
    $configs = include('config.php');
   
    
    $servername = $configs["host"];
    $username = $configs["username"];
    $password = $configs["password"];
    $dbname = $configs["dbname"];
    $dbstorage = $configs["dbstorage"];
    
    
   
    
    
    $conn = mysql_connect($servername, $username, $password);
    mysql_select_db($dbname);
    $eventid = $_POST["eventid"];
    $userid = $_POST["userid"];
    
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
  
   
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        $sql = "DELETE FROM events where id = $eventid ;";
        
        
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        else {
        mysql_select_db($dbstorage, $conn);
        $target_event_table = "Event" . "$eventid";
        $target_user_table = "User" . "$userid";
        
            $sql = "DROP TABLE $target_event_table ;";
        
    
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
            $sql = "delete from $target_user_table where eventids = $eventid;";
       
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
     
        }
      
  
    }
    
    
    
   
    
    
    
    
    
    
    
    ?>
