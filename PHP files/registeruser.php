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
    $ui = new userinfo($_POST);

    $ui->sql();
   
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        $sql = "INSERT INTO users (firstname,lastname,username,birthday,password,eventsattended,eventsrsvped,gender,email) values ($ui->firstname, $ui->lastname, $ui->username, str_to_date($ui->birthday, '%Y-%m-%dT%TZ'), $ui->password, 0, 0, $ui->gender, $ui->email); ";
        
    
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        else {
            $id = (int)mysql_insert_id();
            echo $id;
            mysql_select_db($dbstorage);
            $UserTableName = "User". "$id ";
            $sql = "CREATE TABlE $UserTableName (eventids int(10) unsigned primary key);";
            
            
            $retval = mysql_query( $sql, $conn );
            
            if(! $retval ) {
                die('Could not get data: ' . mysql_error());
            }
            
        }
       
     
       
      
  
    }
    
    
    
   
    
    
    
    
    
    
    
    ?>
