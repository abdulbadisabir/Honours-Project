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
    $longitude = $_POST["longitude"];
    $lattitude = $_POST["lattitude"];
    $searchValue = $_POST["searchValue"] ;
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
    
    
    if ($conn->connect_error) {
        echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
     
        $searchKey = "%".$searchValue. "%";
        
        //$searchValue ? $sql = "SELECT id FROM events WHERE Title LIKE '%$searchValue%' ORDER BY (POW((longitude-$longitude),2) + POW((lattitude-$lattitude),2));" : $sql = "SELECT id FROM events ORDER BY (POW((longitude-$longitude),2) + POW((lattitude-$lattitude),2));";
        $searchValue ? $sql = "SELECT id FROM events WHERE Title LIKE  '$searchKey'" : $sql = "SELECT id FROM events ORDER BY (POW((longitude-$longitude),2) + POW((lattitude-$lattitude),2));";
        
        
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            echo $searchKey;
            die('Could not get data: ' . mysql_error());
        }
        $count = mysql_num_rows($retval);
        if ($count > 0 )
        {
        
          
            
            //echo implode(",",$result);
            $array = Array();
            while($row = mysql_fetch_assoc($retval,MYSQL_ASSOC)) {
                $array[] = $row['id'];
            }
            
           
            
           // echo implode(",",$array);
            echo implode(",",$array) . ",";
            //echo "this is the result \n";
            // echo $result;
            
           // $result = json_encode($result,JSON_NUMERIC_CHECK);
            //echo $result;
            
        }
        else
        {
            
            echo "false";
        }
        
        
     
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    ?>

