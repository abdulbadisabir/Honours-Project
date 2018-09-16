<?php
    $configs = include('config.php');
    
    
    $servername = $configs["host"];
    $username = $configs["username"];
    $password = $configs["password"];
    $dbname = $configs["dbname"];
    
     $conn = mysql_connect($servername, $username, $password);
     mysql_select_db($dbname);
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
    
    if ($conn->connect_error) {
        echo "An error occurred!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        $username = $_POST["username"];
        $sql = "SELECT id FROM users WHERE username = '$username'";
        //$sql = "INSERT INTO users (username,password) VALUES ('hihihi','bbb')";
        $retval = mysql_query( $sql, $conn );
        $result = mysql_fetch_assoc($retval);
        
        $id = $result["id"];
        echo $id;
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        
     //$sql = "UPDATE users SET photopath = '$target_dir"
        
        
    }
     $target_dir = __DIR__ . '/photos';
    if(!file_exists($target_dir)) {
        
        echo "does not exist";
        mkdir($target_dir,0777,true);
    }
    
    
   // echo $_POST["file"]
   $target_dir = $target_dir . "/" . "$id.jpg";   //basename($_FILES["file"]["name"]);
  
   if (move_uploaded_file($_FILES["file"]["tmp_name"],$target_dir)) {
        echo "uploaded photo successfully";
       echo $_POST["username"];
      
       /*
       echo "this is the username \n";
       echo $_FILES["username"];
        */
       $target_dir = $_POST["hostpath"] ."photos/$id.jpg";
       $sql = "UPDATE users SET photopath = '$target_dir' where id = $id";
       $retval = mysql_query( $sql, $conn );
       if(! $retval ) {
           die('Could not get data: ' . mysql_error());
       }
       ;
       
       echo $target_dir;
    }
    else
    {
        echo "failed to upload photo";
        
    }
    
  
    
    //echo filesize($_FILES["file"]["temp_name"]);
    //$processUser = posix_getpwuid(posix_geteuid());
    //echo($processUser['name']);
    /*if (move_uploaded_file("yolo", $target_dir)) {
        echo "all good";
    }
    else
    {
        echo "failed";
    }*/
    //echo $_POST["email"]
    
    ?>
