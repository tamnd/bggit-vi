# Git Alias (Bí danh Git)

[i[Alias]<]

Một số lệnh Git có thể rất phiền khi gõ. Cho đến giờ chúng ta chưa phải làm gì _quá_ phức tạp, nhưng biết đâu rồi sẽ cần đến.

Ví dụ, giả sử bạn muốn xem tên các file được chỉnh sửa kèm theo `git log`. Không vấn đề gì---bạn có thể ra lệnh cho nó làm điều đó.

``` {.default}
$ git log --name-only
```

Và nó sẽ hoạt động.

Nhưng giả sử vì một lý do nào đó bạn thấy mình làm việc đó *rất thường xuyên*. Lâu dần sẽ thấy phiền.

Chẳng phải sẽ tiện hơn nếu bạn có thể tự đặt một lệnh mới, kiểu như `git logn`, để làm y chang việc đó sao?

Đó chính là mục đích của alias (bí danh).

Chương này giả định bạn đã đọc [chương Configuration (cấu hình)](#configuration). Nếu các lệnh dưới đây không hoạt động, hãy xem mục [configuration of Older Git Versions (cấu hình cho phiên bản Git cũ)](#config-old).

## Tạo một Alias

[i[Alias-->Creating]<]

Bạn làm việc này qua giao diện cấu hình. Về cơ bản, biến bạn cần đặt là `alias.myname`, trong đó `myname` là tên lệnh mới.

Giả sử bạn muốn đặt `git logn` là alias cho `git log --name-only`. Bạn có thể làm như sau:

``` {.default}
$ git config set --global alias.logn 'log --name-only'
```

Và từ đây, bạn có thể chạy:

``` {.default}
$ git logn
```

và nó sẽ là alias cho `git log --name-only`, tức là thực thi lệnh đó.

Tôi đoán rằng Git có một số lệnh tích hợp sẵn (như `log` hay `push`) và nếu bạn thử chạy thứ gì đó không phải lệnh tích hợp, nó sẽ thử tìm trong biến `alias`. Nếu tìm thấy, nó sẽ thay thế lệnh đó vào. Tôi 99% chắc đó là những gì đang diễn ra bên dưới mui xe.

Vì alias chỉ là các biến cấu hình thông thường, việc lấy, đặt và xóa chúng được thực hiện như mô tả trong [chương config (cấu hình)](#configuration).

[i[Alias-->Creating]>]

## Hiển thị các Alias

[i[Alias-->Displaying]<]

Vì alias chỉ là biến cấu hình, bạn có thể đơn giản là lấy chúng ra để xem.

``` {.default}
$ git config get alias.logx
```

Nếu muốn xem tất cả alias, bạn có thể chạy lệnh này:

``` {.default}
$ git config get --all --show-names --regexp '^alias\.'
```

lệnh này khá khó chịu khi phải gõ. Tôi đề nghị bạn nên đặt alias cho nó luôn. Wheee!

> **Phiên bản Git cũ hơn dùng lệnh này thay thế:**
> ``` {.display}
> $ git config --get-regexp ^alias\.
> ```
> <!-- ` -->

[i[Alias-->Displaying]>]

## Một Số Alias Mẫu Hay Ho

[i[Alias-->Examples]<]

Một số lệnh dưới đây được chia thành nhiều dòng cho vừa trang sách. Bạn có thể viết chúng trên một dòng, hoặc nhập như vậy với ký tự `\` là dấu thoát báo cho shell biết tiếp tục lệnh ở dòng sau.

**Thêm tất cả file đã thay đổi** với `git adda`. Làm cẩn thận vì có thể bạn sẽ thêm nhiều hơn mức muốn!

``` {.default}
$ git config set alias.adda "add --all"
```

**Log gọn hơn có hiển thị commit graph (đồ thị commit)** với `git logc`.

``` {.default}
$ git config set alias.logc "log --oneline --graph --decorate"
```

**So sánh stage với repo** với `git diffs`.

``` {.default}
$ git config set alias.diffs "diff --staged"
```

**Hiển thị tất cả alias** với `git aliases`.

``` {.default}
$ git config set alias.aliases \
    "config get --all --show-names --regexp '^alias\.'"
```

**Tạo một log đầy màu sắc và tùy biến cao** với `git lol`.

(Hãy đảm bảo khoảng trắng chính xác khi copy-paste, nếu không shell và/hoặc Git sẽ không vui.)

``` {.default}
$ git config set alias.lol "log --graph"\
" --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s"\
" %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

Với cái cuối đó, chúng ta đang dùng nhiều tùy chọn `--pretty` để kiểm soát đầu ra. [fl[Xem mục "Pretty Formats" trong trang hướng dẫn `git log` để biết thêm|https://git-scm.com/docs/git-log#_pretty_formats]].

[i[Alias-->Examples]>]

## Xem Git Mở Rộng Alias Như Thế Nào

[i[Alias-->Debugging]<]

Giả sử bạn đã thêm một alias nhưng nó không hoạt động. Khi chạy, nó chỉ trả về lỗi mà không rõ chuyện gì đang xảy ra.

``` {.default}
$ git logx
fatal: unrecognized argument: --foobar
```

Bạn có thể yêu cầu Git cung cấp thêm thông tin bằng cách thêm `GIT_TRACE=1` vào đầu dòng lệnh.

> **Cách này đặt biến môi trường (environment variable) `GIT_TRACE` thành `1`,** nhưng chỉ cho lệnh này mà thôi. Không phải cố định. Git biết cách tìm `GIT_TRACE` và sẽ thay đổi hành vi nếu thấy nó.

Đây là một ví dụ về output:

``` {.default}
$ GIT_TRACE=1 git logx
  14:09:28.502707 git.c:758               trace: exec: git-logx
  14:09:28.502750 run-command.c:666       trace: run_command: git-l
  14:09:28.502905 git.c:416               trace: alias expansion: l
  14:09:28.502913 git.c:816               trace: exec: git log --fo
  14:09:28.502916 run-command.c:666       trace: run_command: git l
  14:09:28.502926 run-command.c:758       trace: start_command: /us
  14:09:28.504192 git.c:472               trace: built-in: git log 
  fatal: unrecognized argument: --foobar
```

Tiếc là tôi phải cắt bớt các dòng bên phải để vừa với trang in, và đó mới chính xác là thứ chúng ta muốn nhìn. Sẽ đến phần đó trong giây lát.

Trước tiên, hãy nhìn vào bên trái. Chúng ta thấy timestamp (dấu thời gian) và thông tin về phần nào trong mã nguồn Git đang gửi trace ra. Rồi kết thúc bằng lỗi của chúng ta.

Hãy cuộn sang phải và chỉ nhìn vào các dòng sau `trace:`.

``` {.default}
trace: exec: git-logx
trace: run_command: git-logx
trace: alias expansion: logx => log --foobar
trace: exec: git log --foobar
trace: run_command: git log --foobar
trace: start_command: /usr/lib/git-core/git log --foobar
trace: built-in: git log --foobar
```

Có thể cần lọc một chút, nhưng hãy chỉ nhìn vào các dòng có `run_command` và `alias expansion`:

``` {.default}
trace: run_command: git-logx
trace: alias expansion: logx => log --foobar
trace: run_command: git log --foobar
```

Và ở đó chúng ta có thể thấy chính xác cái gì được mở rộng thành cái gì. Điều đó có thể hữu ích để debug.

Với ví dụ đơn giản này thì hơi quá đà, nhưng có những alias cực kỳ phức tạp mà kỹ thuật này có thể giúp ích.

[i[Alias-->Debugging]>]

[i[Alias]>]
