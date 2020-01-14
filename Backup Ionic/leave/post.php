<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: content-type");

// First, include Requests
include('./library/Requests.php');

// Next, make sure Requests can load internal classes
Requests::register_autoloader();

// Retrieve the posted data
$json    =  file_get_contents('php://input');
$obj     =  json_decode($json);
$email =  strip_tags($obj->email);
$password =  strip_tags($obj->password);

$headers = array('x-api-key' => '0fXZd5W34FOSlMgGVuosFBwe9mNVPRIa');
$fields = array('email' => $email, 'password' => $password);
$request = Requests::post('http://mobile.usm.my/proxy/auth/api/login', $headers, $fields);

$json = $request->body;

// Now let's make a request!
// $request = Requests::post('http://httpbin.org/post', array(), array('mydata' => 'something'));

// Check what we received
//var_dump($request);
echo $json;