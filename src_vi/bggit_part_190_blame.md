# Ai Chịu Trách Nhiệm Về Đoạn Code Này?

[i[Blame]<]

Giả sử bạn tìm thấy thứ gì đó trong codebase chung mà hoàn toàn sai. Hoặc, nói
nhẹ hơn, chúng ta sẽ nói bạn tìm thấy thứ gì đó _thú vị_.

Và bạn muốn biết ai phải chịu trách nhiệm về đoạn code _tuyệt vời_ đó.

Đây là lúc một lệnh Git đơn giản có thể khai sáng cho bạn.

Đây là một ví dụ output đã được cắt ngắn (để vừa trong lề sách):

``` {.default}
$ git blame --date=short foo.py
  8c96991f (Alice 2024-10-08  4) def encode_data(message, value):
  8c96991f (Alice 2024-10-08  5)     encoded_message = message.enco
  8c96991f (Alice 2024-10-08  6)     encoded_value = value.to_bytes
  3b0b0e76 (Chris 2024-10-09  7)     length = len(encoded_message) 
  3b0b0e76 (Chris 2024-10-09  8)     encoded_length = length.to_byt
  8c96991f (Alice 2024-10-08  9)
  8c96991f (Alice 2024-10-08 10)     data = encoded_length + encode
  8c96991f (Alice 2024-10-08 11)
  8c96991f (Alice 2024-10-08 12)     return data
```

Tôi có switch `--date=short` trong đó để nén nó thêm nữa để vừa trong sách. Nếu
không nó sẽ hiển thị timestamp đầy đủ.

Những gì chúng ta thấy trong ví dụ giả mạo này là Alice đã check in (gửi vào)
phần lớn hàm này, nhưng ngày hôm sau Chris đến và đã chỉnh sửa hoặc thêm những
dòng bổ sung ở giữa.

Và bây giờ chúng ta biết rồi.

## Blame Nâng Cao Hơn

[i[Blame-->Fancier output]<]

Bạn có thể dùng switch `--color-lines` để có output màu, xen kẽ màu giữa các
commit. Rất thú vị. Nếu bạn muốn điều đó luôn xảy ra, bạn có thể đặt tùy chọn
cấu hình `color.blame.repeatedLines`.

Chúng ta đã thấy `--date=short` để cắt ngắn ngày một chút.

Bạn có thể hiển thị địa chỉ email của người đóng góp với `-e` hoặc
`--show-email`.

Bạn có thể phát hiện đáng tin cậy các dòng đã được di chuyển hoặc sao chép
trong một file với `-M`. Và bạn có thể làm điều tương tự trên nhiều file với
`-C`.

Cuối cùng, IDE của bạn (như VS Code) có thể hỗ trợ blame, hoặc natively (tích
hợp sẵn) hoặc qua extension (tiện ích mở rộng). Một số người luôn bật tính năng
này.

[i[Blame-->Fancier output]>]

[i[Blame]>]
