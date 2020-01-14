<?php
header("Access-Control-Allow-Origin: *");

   // Define database connection parameters
   $hn      = 'localhost';
   $un      = 'root';
   $pwd     = '';
   $db      = 'leave';
   $cs      = 'utf8';

   // Set up the PDO parameters
   $dsn 	= "mysql:host=" . $hn . ";port=3306;dbname=" . $db . ";charset=" . $cs;
   $opt 	= array(
                        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
                        PDO::ATTR_EMULATE_PREPARES   => false,
                       );
   // Create a PDO instance (connect to the database)
   $pdo 	= new PDO($dsn, $un, $pwd, $opt);


   // Retrieve the posted data
   $json    =  file_get_contents('php://input');
   $obj     =  json_decode($json);
   $key     =  strip_tags($obj->key);
      
   // Determine which mode is being requested
   switch($key)
   {

      // Add new record to the cutiseparuhhari table
      case "addLeave":

         // Sanitise URL supplied values
         $motive = filter_var($obj->motive, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
         $duration1 = filter_var($obj->duration1, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
		   $duration2 = filter_var($obj->duration2, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
         $dateApplication = filter_var($obj->dateApplication, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
	
       

		 
         // Attempt to run PDO prepared statement
         try {
            $sql 	= "INSERT INTO application(motive, duration1, duration2, dateApplication ) VALUES(:motive, :duration1, :duration2, :dateApplication)";
            $stmt 	= $pdo->prepare($sql);
            $stmt->bindParam(':motive', $motive, PDO::PARAM_STR);
            $stmt->bindParam(':duration1', $duration1, PDO::PARAM_STR);
			   $stmt->bindParam(':duration2', $duration2, PDO::PARAM_STR);
            $stmt->bindParam(':dateApplication', $dateApplication, PDO::PARAM_STR);

			
            $stmt->execute();

            echo json_encode(array('message' => 'Congratulations the record was added to the database'));
         }
         // Catch any errors in running the prepared statement
         catch(PDOException $e)
         {
            echo $e->getMessage();
         }

      break;



      // Update an existing record in the cutiseparuhhari table
      case "updatePermohonan":

         // Sanitise URL supplied values
		 $staffName = filter_var($obj->staffName, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $position = filter_var($obj->position, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $staffNo = filter_var($obj->staffNo, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $telNo = filter_var($obj->telNo, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $firstDayDate = filter_var($obj->firstDayDate, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $firstDayTime = filter_var($obj->firstDayTime, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $secondDayDate = filter_var($obj->secondDayDate, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $secondDayTime = filter_var($obj->secondDayTime, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
       $id = filter_var($obj->id, FILTER_SANITIZE_STRING, FILTER_FLAG_ENCODE_LOW);
         

         // Attempt to run PDO prepared statement
         try {
            $sql 	= "UPDATE cutiseparuhhari SET staffName = :staffName, position = :position, staffNo = :staffNo, telNo = :telNo, firstDayDate = :firstDayDate, firstDayTime = :firstDayTime, secondDayDate = :secondDayDate, secondDayTime = :secondDayTime WHERE id = :id";
            $stmt 	=	$pdo->prepare($sql);
			   $stmt->bindParam(':staffName', $staffName, PDO::PARAM_STR);
            $stmt->bindParam(':position', $position, PDO::PARAM_STR);
            $stmt->bindParam(':staffNo', $staffNo, PDO::PARAM_STR);
            $stmt->bindParam(':telNo', $telNo, PDO::PARAM_STR);
            $stmt->bindParam(':firstDayDate', $firstDayDate, PDO::PARAM_STR);
            $stmt->bindParam(':firstDayTime', $firstDayTime, PDO::PARAM_STR);
            $stmt->bindParam(':secondDayDate', $secondDayDate, PDO::PARAM_STR);
            $stmt->bindParam(':secondDayTime', $secondDayTime, PDO::PARAM_STR);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

            echo json_encode('Congratulations the record was updated');
         }
         // Catch any errors in running the prepared statement
         catch(PDOException $e)
         {
            echo $e->getMessage();
         }

      break;



      // Remove an existing record in the cutiseparuhhari table
      case "deletePermohonan":

         // Sanitise supplied record ID for matching to table record
         $id	=	filter_var($obj->id, FILTER_SANITIZE_NUMBER_INT);

         // Attempt to run PDO prepared statement
         try {
            $pdo 	= new PDO($dsn, $un, $pwd);
            $sql 	= "DELETE FROM cutiseparuhhari WHERE id = :id";
            $stmt 	= $pdo->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

            echo json_encode('Congratulations the record was removed');
         }
         // Catch any errors in running the prepared statement
         catch(PDOException $e)
         {
            echo $e->getMessage();
         }

      break;
   }

?>