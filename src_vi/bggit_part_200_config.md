# Cấu Hình {#configuration}

[i[Configuration]<]

Hồi đầu cuốn sách này, chúng ta đã thực hiện một số cấu hình Git. Chúng ta đã
làm thế này:

``` {.default}
$ git config set --global user.name "Your Name"
$ git config set --global user.email "your-email@example.com"
```

Khi làm vậy, nó đã thêm thông tin cấu hình đó vào một file và thông tin trong
file đó áp dụng cho tất cả repo Git trên hệ thống của bạn.

Trừ khi bạn ghi đè chúng bằng cấu hình local. Nhưng chờ thêm về điều đó sau.

> **Một số bạn có thể nói, "Này, tôi chưa bao giờ viết `set` trước đây để đặt
> biến với `git config`!"** Và bạn đúng. Nhưng đó là cách cũ, đã deprecated
> (lỗi thời) của dùng `git config`. Nếu bạn đang dùng phiên bản Git cũ hơn,
> cách deprecated có thể là cách duy nhất. Vì vậy nếu bạn gặp lỗi với cách
> dùng mới, xem [Phiên Bản Git Cũ Hơn](#config-old), phía dưới.

Hãy nhìn lại một trong những dòng đó:

``` {.default}
$ git config set --global user.name "Your Name"
                              ↑          ↑
                          variable     value
```

Có hai thứ chính trong dòng này.

1. Một *variable* (biến), tức là thứ chúng ta đang đặt giá trị.
2. Một *value* (giá trị), giá trị chúng ta gán cho biến đó.

Trong trường hợp đó, biến là `user.name` và giá trị là `"Your Name"`.

> **Hai biến đó, `user.name` và `user.email`, đang làm gì** là chúng đang đặt
> các giá trị sẽ đi vào commit message của bạn! Đó là danh tính của bạn khi bạn
> commit! Một lưu ý bên lề là việc mạo danh bất kỳ ai khác trên thế giới cực
> kỳ dễ dàng chỉ bằng cách đặt tên và email của họ vào đó. Để giảm thiểu điều
> này, một lựa chọn là
> [fl[ký số hóa commit của bạn|https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work]],
> điều mà bạn có thể đọc thêm một chút trong chương [Thay Đổi Danh Tính](#changing-identity).

Nếu các lệnh trong chương này đang báo lỗi, xem phần về [các phiên bản Git
cũ hơn](#config-old), phía dưới.

## Cấu Hình Local

[i[Configuration-->Local]<]

Trong những dòng `git config` đó, ở trên, bạn có thể đã thấy switch `--global`:

``` {.default}
$ git config set --global user.name "Your Name"
```

Trừ khi bạn nói rõ `--global`, Git giả định bạn có ý muốn cấu hình local.

Cấu hình local là gì? Đó là cấu hình áp dụng cho repo mà bạn đang ở trong đó,
và không cho repo nào khác.

*Các tùy chọn cấu hình trong config local ghi đè config global!*

Đây là ví dụ thực tế về lý do tại sao bạn có thể làm điều này. Giả sử bạn có
email cá nhân cho các dự án vui, và email nhà thầu bạn dùng cho công việc thuê.
Nhưng vì bạn là nhà thầu độc lập, bạn có tất cả các dự án này trên một máy tính.

Tuy nhiên, bạn muốn dùng danh tính công việc (tên và email) cho công việc hợp
đồng và danh tính hacker cho công việc vui.

Một điều bạn có thể làm là đặt toàn cục như sau:

``` {.default}
$ git config set --global user.name "HAx0rBYnit3"
$ git config set --global user.email "l333T@example.com"
```

và đó sẽ là mặc định cho tất cả repo của bạn. Và sau đó bạn có thể có repo mới
cho một công việc:

``` {.default}
$ git init corporate_job_12
  Initialized empty Git repository in /user/corporate_job_12/.git/
```

Và chúng ta vào đó, và đặt config local chỉ cho repo đó (nó là local vì chúng
ta không chỉ định `--global`):

``` {.default}
$ cd corporate_job_12
$ git config set user.name "Professional Name"
$ git config set user.email "professional@example.com"
```

Và giờ, chỉ trong thư mục `corporate_job_12`, chúng ta sẽ dùng tên và email
chuyên nghiệp trong commit. Ở mọi nơi khác chúng ta sẽ dùng tên hacker ưu tú.

Bạn có thể ghi đè tất cả các config global trên cơ sở từng repo bằng cách chỉ
định các config local.

Cuối cùng, config local cho một repo được tìm thấy trong file `.git/config` từ
thư mục root của repo.

[i[Configuration-->Local]>]

## Liệt Kê Config Hiện Tại

[i[Configuration-->Listing]<]

Bạn có thể xem config hiện tại với `git config list`. Thêm flag `--global` nếu
bạn muốn xem config global.

``` {.default}
$ git config list
  user.name=HAx0rBYnit3
  user.email=l333T@example.com
  init.defaultbranch=main
  core.repositoryformatversion=0
  core.filemode=true
  core.bare=false
  core.logallrefupdates=true
  user.name=Professional Name
  user.email=professional@example.com
```

Bạn có thể thấy trong đó rằng `user.name` và `user.email` xuất hiện hai lần.
Cái đầu tiên từ config global, cái sau bị ghi đè bởi giá trị trong config local.

[i[Configuration-->Listing]>]

## Lấy, Đặt, và Xóa Biến

[i[Configuration-->Get]]
Ví dụ "get" (lấy):

``` {.default}
$ git config get user.name
  Professional Name
```

Lưu ý rằng nó chỉ đưa ra giá trị đang hoạt động (cái local trong trường hợp
này) mặc dù chúng ta thấy với `git config list` rằng cả giá trị global lẫn
local đều có ở đó.

[i[Configuration-->Set]]
Và chúng ta đã thấy "set" (đặt):

``` {.default}
$ git config set user.name "Harvey Manfrengensenton"
```

Dấu nháy kép ở đó để shell đưa tên như một đối số duy nhất. Thông thường nó
tách tất cả đối số theo khoảng trắng. Bạn cũng có thể dùng dấu nháy đơn, hữu
ích nếu giá trị có ký tự shell đặc biệt. Quy tắc đơn giản hóa thô thiển, xin
lỗi những người yêu thích shell, là dùng dấu nháy xung quanh giá trị nếu nó có
khoảng trắng.

Set sẽ ghi đè bất kỳ giá trị nào đã tồn tại trước đó của biến `user.name`.

[i[Configuration-->Delete]]
[i[Configuration-->Unset]]
Và cuối cùng không kém phần quan trọng, chúng ta có thể xóa biến với `unset`:

``` {.default}
$ git config unset user.name
```

## Một Số Biến Phổ Biến

[i[Configuration-->Commonly-set variables]<]

Để xem các biến bạn có thể đặt, hãy xem trang manual cho lệnh phù hợp. Bạn
thường có thể đến đó bằng cách tìm hit đầu tiên trên công cụ tìm kiếm yêu thích
của bạn với `man git whatever`. Ví dụ, bạn có thể tìm thấy các biến cấu hình
cho `git pull` bằng cách tìm kiếm `man git pull` và mở hit đầu tiên.

Nói vậy, có [fl[danh sách lớn trong trang manual `git config` mà bạn có thể xem
qua|https://git-scm.com/docs/git-config#_variables]].

Nhưng đây là một số cái thú vị, phổ biến.

Variable        | Mô tả
----------------|----------------------------------------------------------
`user.name`        | Tên của bạn
`user.email`       | Email của bạn
`pull.rebase`      | Đặt `true` để pull cố rebase. Đặt `false` để thử merge.
`core.editor`      | Editor mặc định của bạn cho commit message, v.v. Đặt là `vim`, `nano`, `code`, `emacs`, hoặc bất cứ thứ gì.
`merge.tool`       | Merge tool mặc định của bạn, ví dụ `meld` hoặc bất cứ thứ gì.
`diff.tool`        | Diff tool mặc định của bạn, ví dụ `vimdiff`
`difftool.prompt`  | Đặt `false` để ngăn Git luôn hỏi bạn có muốn khởi chạy difftool không.
`color.ui`         | Đặt `true` để có output Git màu sắc hơn
`core.autocrlf`    | Đặt `true` nếu bạn đang dùng Windows **và** không trong WSL **và** repo remote có newline kiểu Unix **và** bạn muốn dùng newline kiểu Windows trong working directory. Trên các hệ thống khác, đặt là `input`. Tất cả về cách xử lý newline cổ lỗi của Windows.
`commit.gpgsign`   | Đặt `true` nếu bạn đã cấu hình [GPG commit signing](#gpg-signing) và muốn luôn ký.
`help.autocorrect` | Đặt `0` để hiển thị lệnh Git nghĩ bạn muốn gõ nếu bạn viết sai chính tả. Đặt `immediate` để chạy lệnh đã sửa ngay. Đặt `prompt` để hỏi bạn có muốn chạy nó không.

Một lần nữa, có *rất nhiều* cái nữa. Xem docs để biết thêm.

[i[Configuration-->Commonly-set variables]>]

## Chỉnh Sửa Config Trực Tiếp

[i[Configuration-->Editing directly]<]

Bạn có thể khởi chạy editor (cái được chỉ định trong biến `core.editor`) để
chỉnh sửa file config trực tiếp. Một số người có thể thấy điều này dễ hơn.

Tôi có thể khởi chạy editor như sau:

``` {.default}
$ git config edit
```

Thêm flag `--global` để chỉnh sửa file config global.

Khi vào editor, bạn sẽ thấy file config có thể trông như thế này:

``` {.default .numberLines}
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true

[user]
    name = Your Name
    email = user@example.com
```

Nếu bạn nhìn, bạn có thể thấy `user.name` và `user.email` đã kết thúc ở đâu.
Đó là cách file config được tổ chức.

Vậy bạn có thể chỉnh sửa nó ở đây và lưu những thay đổi đó. Một số người có
thể thấy cách này dễ hơn so với thêm hoặc chỉnh sửa biến trên command line.

> **Nếu bạn làm hỏng config bằng việc chỉnh sửa cẩu thả, bạn sẽ có thời gian
> thú vị đấy.** Bạn sẽ không thể chạy `git config edit` nữa. Bạn sẽ phải sửa
> file config thủ công trong editor văn bản yêu thích của mình.
>
> File config local có thể được tìm thấy tương đối so với thư mục root cho repo
> liên quan trong `.git/config`.
>
> File config global có thể được tìm thấy tại `~/.gitconfig` trên các hệ thống
> giống Unix và `C:\Users\YourName\.gitconfig` trên Windows.
>
> Mở file phù hợp trong editor, sửa lỗi, lưu nó, và sau đó `git config edit`
> sẽ hoạt động trở lại.

[i[Configuration-->Editing directly]>]

## Cấu Hình Có Điều Kiện

[i[Configuration-->Conditional]<]

Đây là nhiều hơn tôi muốn nói, nhưng nó đủ hay để đề cập.

Trong các file config Git, bạn có thể *include* (bao gồm) các file config khác.
Điều này cho bạn một cách, nếu các file config của bạn trở nên phức tạp, để chia
chúng ra theo logic.

Bạn cũng có thể thực hiện *conditional includes* (bao gồm có điều kiện). Tức
là, bạn có thể chọn bao gồm một file dựa trên một số điều kiện là đúng.

Các điều kiện có thể kiểm tra:

* Repo này đang ở thư mục nào
* Nếu bạn đang ở trên một nhánh cụ thể
* Nếu có một remote cụ thể được cấu hình

Điều này cho bạn đủ loại quyền lực. Cá nhân tôi, tất cả điều đó nhiều hơn tôi
cần, và tôi chưa bao giờ dùng tính năng này, nhưng đó chỉ là tôi.

[fl[Lấy thêm thông tin và ví dụ trong cuốn sách chính thức|https://git-scm.com/docs/git-config#_conditional_includes]].

[i[Configuration-->Conditional]>]

## Phiên Bản Git Cũ Hơn {#config-old}

[i[Configuration-->Deprecated usage]<]

Tôi giả sử bạn đã cài đặt phiên bản Git gần đây. Nhưng nếu không, các lệnh này
có thể khác.

[fl[Trang manual Git cho `git config` có tóm tắt đầy đủ các thay
đổi|https://git-scm.com/docs/git-config#_deprecated_modes]].

Và đây là các lệnh hiện đại chúng ta đã dùng trong chương này:

```{.default}
git config get user.email                     # Get
git config set user.email "user@example.com"  # Set
git config unset user.email                   # Delete
git config list                               # List
git config edit                               # Edit
```

Và đây là các tương đương cũ hơn:

``` {.default}
git config user.email                     # Get
git config user.email "user@example.com"  # Set
git config --unset user.email             # Delete
git config --list                         # List
git config --edit                         # Edit
```

Hãy dùng cái mới nếu bạn có thể!

[i[Configuration-->Deprecated usage]>]

[i[Configuration]>]
