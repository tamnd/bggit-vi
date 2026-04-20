# Phụ lục: Thoát Khỏi Editor {#editor-get-out}

[i[Exiting editors]<]

Nếu bạn thử `git commit` mà không chỉ định `-m` để nhập message, hoặc
`git pull` gặp merge không fast-forward, hoặc `git merge` gặp merge không
fast-forward mà không dùng `-m`, hay vì một lý do nào đó khác, bạn có thể
bị hất vào trong một editor (trình soạn thảo).

Và bạn có thể không quen với editor đó.

Vậy đây là cách thoát ra.

* **Nano**: Nếu editor hiện chữ "Nano" hay "Pico" ở góc trên bên trái,
  hãy chỉnh sửa commit message (nếu muốn), rồi nhấn `CTRL-X`, tiếp theo
  nhấn `Y` để lưu, rồi `ENTER` để chấp nhận tên file được gợi ý.

* **Vim**: Nếu màn hình có một đống ký tự `~` dọc bên trái và tên file
  trông kỳ cục ở phía dưới cùng, có thể kèm chữ `All`, bạn đang ở trong
  Vim hoặc một biến thể vi ("vee eye") nào đó. Nhấn `i`, gõ message (nếu
  muốn), rồi nhấn phím `ESC` ở góc trên bên trái, sau đó gõ hai chữ `Z`
  hoa liên tiếp. `ZZ`. Vậy là lưu và thoát.

  Tôi rất thích Vim. Nhưng phải mất một thời gian mới quen. Nếu muốn tìm
  hiểu thêm, xem [Phụ lục về Dùng Vim](#vim-tutorial), có hướng dẫn ngắn
  gọn nhất có thể. À, đoạn trên mới là ngắn gọn nhất, nên cái kia sẽ là
  ngắn gọn thứ hai.

[i[Exiting editors]>]
