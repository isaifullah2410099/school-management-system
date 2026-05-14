<?php
    $server = "127.0.0.1";
   
    $user = "sms_user";
    $password = "";
    $db = "_sms";

    function is_ajax_request(): bool {
        return !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
    }

    function exit_json_error(string $message): void {
        if (!headers_sent()) {
            header('Content-Type: application/json');
        }
        echo json_encode([
            'status' => 'error',
            'message' => $message,
        ]);
        exit();
    }

    if (!function_exists('mysqli_connect')) {
        if (is_ajax_request()) {
            exit_json_error('PHP mysqli extension is not installed or enabled.');
        }
        exit('PHP mysqli extension is not installed or enabled.');
    }

    $conn = mysqli_connect($server, $user, $password, $db);

    if (!$conn) {
        if (is_ajax_request()) {
            exit_json_error('Database connection failed: ' . mysqli_connect_error());
        }
        header('Location: ../errors/error.html');
        exit();
    }


?>