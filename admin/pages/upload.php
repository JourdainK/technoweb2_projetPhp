<?php

// Check if the image was uploaded
if (isset($_FILES['image'])) {
    // Get the image file path
    $image_path = $_FILES['image']['tmp_name'];

    // Check if the file is an image
    if (exif_imagetype($image_path)) {
        // Save the image to a desired location
        move_uploaded_file($image_path, '../images/');
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'The uploaded file is not an image']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'No image was uploaded']);
}

?>