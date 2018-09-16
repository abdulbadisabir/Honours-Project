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
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
    $_POST = json_decode(file_get_contents('php://input'), true);
    $ei = new eventinfo($_POST);
    $Owner = $ei->Owner;
    $ei->sql();
  
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        $sql = "INSERT INTO events (Owner,StartTime,EndTime,Title,Description,Male,Female,LeastAge,MaxAge, Address,longitude,lattitude,Duration) values ($ei->Owner, str_to_date($ei->StartTime,'%Y-%m-%dT%TZ'), str_to_date($ei->EndTime, '%Y-%m-%dT%TZ'), $ei->Title, $ei->Description, $ei->Male, $ei->Female, $ei->LeastAge, $ei->MaxAge, $ei->Address, $ei->longitude,$ei->lattitude,$ei->Duration ); ";
        
        
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        else {
            $id = (int)mysql_insert_id();
        echo $id;
            mysql_select_db($dbstorage, $conn);
            $EventTableName = "Event". "$id";
            $sql = "CREATE TABlE $EventTableName (userids int(10) unsigned primary key, attended bool);";
        
            
            $retval = mysql_query( $sql, $conn );
            
            if(! $retval ) {
                die('Could not get data: ' . mysql_error());
            }
             $sql = "INSERT INTO $EventTableName (userids, attended) values ($Owner, 0);";
            
            $retval = mysql_query( $sql, $conn );
            
            if(! $retval ) {
                die('Could not get data: ' . mysql_error());
            }
            
            $UserTableName = "User" . "$Owner";
            $sql = "INSERT INTO $UserTableName (eventids) values ($id);";
            
            
            $retval = mysql_query( $sql, $conn );
            
            if(! $retval ) {
                die('Could not get data: ' . mysql_error());
            }
    
        }
      
  
    }
    
    
    
   
    
    
    
    
    
    
    
    ?>
