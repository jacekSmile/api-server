// use std::io::Cursor;
// use axum::body::Bytes;
// use image::io::Reader as ImageReader;

// // 压缩图片
// fn compressImage(image_data: Vec<u8>) -> String {
//     let image_data = ImageReader::new(Cursor::new(image_data)).with_guessed_format().expect("Cursor io never fails").decode().expect("decode image failed");
//     let decoder = png::Decoder::new();
//     todo!();
// }