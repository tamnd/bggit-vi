# Phụ lục: Đủ Dùng Vim {#vim-tutorial}

[fl[Vim|https://www.vim.org/]] là editor (trình soạn thảo) được cài sẵn rất
phổ biến, nhưng có đường cong học tập khá dốc.

Phụ lục này chỉ để cho bạn đủ Vim để không bị bí!

## Khởi động Vim

Có thể bạn rơi vào Vim vì đang commit mà quên dùng `-m` để chỉ định message.
Bạn sẽ biết ngay nếu thấy một đống ký tự `~` dọc bên trái và thanh trạng
thái ở phía dưới.

Hoặc bạn có thể tự mở nó bằng lệnh kiểu này, để chỉnh sửa `foo.c`:

``` {.default}
$ vim foo.c
```

## Chỉnh Sửa Theo Chế Độ

Vim tồn tại chủ yếu ở hai chế độ:

* ***Insert Mode*** (chế độ chèn): Đây là chế độ bạn nhấn phím và các ký tự
  tương ứng xuất hiện trong tài liệu, giống như mọi editor bình thường khác.

* ***Normal mode*** (chế độ thường): Đây là chế độ đặc biệt của Vim mà bạn
  gần như không gặp ở bất kỳ editor nào khác. Trong chế độ này, các phím có
  ý nghĩa đặc biệt. Ví dụ, phím `h` di chuyển con trỏ sang trái một ký tự.

  **Editor khởi động ở normal mode!** Đó là lý do khi bị hất vào Vim, không
  có phím nào làm đúng việc bạn muốn.

Sức mạnh của Vim đến từ việc thuộc lòng *hàng tấn* lệnh Normal Mode. Điều
này cho phép di chuyển con trỏ và chỉnh sửa với tốc độ cao. [fl[Trang web
vimhelp có tài liệu tham khảo tất cả lệnh normal mode|https://vimhelp.org/index.txt.html#normal-index]],
chỉ để bạn có ý niệm sơ bộ về những gì có thể làm.

Nhưng lúc đầu, khi gần như không biết lệnh Normal Mode nào, việc chỉnh sửa
theo chế độ có vẻ chỉ cản trở. Nhưng khi thành thạo hơn, bạn sẽ thấy đây
thực sự là một tính năng rất mạnh.

## Chuyển Giữa Các Chế Độ

Đây là hai chế độ chính:

* Để chuyển từ *normal mode* sang *insert mode*, nhấn `i`.
* Để chuyển từ *insert mode* trở lại *normal mode*, nhấn `ESC`. (Đó là
  phím "escape" ở góc trên bên trái bàn phím.)

Đó! Bạn đã học được một lệnh normal mode! `i` để chèn văn bản!

> **Thử xem:** mở Vim, gõ `i`, rồi gõ `hello world!`, rồi nhấn `ESC` để
> trở về normal mode.

## Di Chuyển Con Trỏ

Bạn có thể dùng các phím mũi tên. Thực ra, phiên bản Vim của bạn có thể
cho phép dùng chúng ngay cả khi đang ở insert mode.

Người dùng Vim *thực thụ* di chuyển con trỏ trong normal mode bằng các phím sau.

* Lên: `k`
* Xuống: `j`
* Sang trái: `h`
* Sang phải: `l`

Cơ bắp sẽ ghi nhớ những phím này theo thời gian.

Nếu đang ở insert mode, phím delete cũng hoạt động bình thường.

## Thêm Chế Độ

Tôi nói có hai chế độ chính, nhưng thực ra có nhiều hơn. Đây là hai chế độ
thêm:

* Để chuyển từ *normal mode* sang *command-line mode* (chế độ dòng lệnh),
  nhấn `:`. Thêm chi tiết bên dưới.
* Để chuyển từ *normal mode* sang *search mode* (chế độ tìm kiếm), nhập `/`.
  Gõ chuỗi cần tìm.

## Chế Độ Dòng Lệnh

Như đề cập ở trên, nếu đang ở normal mode, bạn có thể nhấn `:` để vào
***command line mode***.

Lệnh này di chuyển con trỏ xuống cuối màn hình và cho phép gõ lệnh ở đó.

Vậy từ đây trong chương này, khi tôi nói điều gì đó như `:q!`, tức là gõ
ba ký tự đó từ normal mode.

Nếu vào command line mode và muốn trở lại normal mode, chỉ cần nhấn Enter
mà không gõ lệnh gì.

## Thoát Vim

Có một vài cách, và tất cả đều bắt đầu từ normal mode. (Vậy hãy nhấn `ESC`
sau khi nhập xong văn bản, rồi thử thoát.)

* `ZZ` --- thoát, chỉ lưu khi có thay đổi
* `:wq` --- thoát, luôn lưu ("write, quit")
* `:q` --- thoát, không lưu
* `:q!` --- thoát, không lưu dù có thay đổi!

Và thêm một cái hữu ích cho Git:

* `:cq` --- thoát với exit status (mã thoát) khác không (tức là lỗi)

Nếu bạn `:cq` khi đang nhập commit message trong Vim, Git sẽ cho là có lỗi
và không hoàn thành commit. Vậy nếu thấy mình trong Vim đang viết commit
message và nghĩ "Tôi chưa muốn làm điều này!", bạn có thể `:cq` để thoát.
Các file sẽ vẫn còn trên stage.

## Tìm Hiểu Thêm

Nếu bạn đã cài Vim, bạn cũng đã có Vim Tutor rồi! Đây chỉ là một file
được mở ra và hướng dẫn bạn cách dùng và học vim.

Khởi động bằng:

``` {.default}
$ vimtutor
```

Nếu không muốn mày mò lúc này, chỉ cần `:q!` để thoát.

Ngoài ra còn có hướng dẫn tương tác online tên
[fl[OpenVim|https://openvim.com/]] dẫn bạn qua những bước đầu tiên.

Cuối cùng, [fl[ChatGPT|https://chatgpt.com/]] hay các AI khác sẽ rất hữu
ích trong việc tìm lệnh normal mode mới và trả lời câu hỏi.

> _"Đây là cơ hội cuối của bạn. Sau đây không còn đường quay lại. Bạn uống
> viên thuốc xanh, câu chuyện kết thúc. Bạn thức dậy dùng editor bình thường
> của mình và chỉnh sửa file theo cách bạn muốn. Bạn uống viên thuốc đỏ,
> bạn ở lại trong Vim và tôi cho bạn thấy lỗ thỏ sâu đến mức nào."_
>
> \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ---Xin lỗi Morpheus, _The Matrix_
