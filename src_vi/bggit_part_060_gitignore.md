# Bỏ Qua Files với `.gitignore`

[i[`.gitignore` file]<]

Nếu bạn có các file trong subdirectory của mình mà bạn không muốn Git
để ý đến thì sao? Ví dụ có thể bạn có một số file tạm thời mà bạn không
muốn thấy trong repo. Hoặc có thể bạn có một executable (file thực thi)
mà bạn đã build từ một dự án C và bạn không muốn cái đó được checked in
vì instructor (giảng viên) cực kỳ nghiêm khắc của bạn sẽ không chấm
điểm dự án nếu repo chứa bất kỳ build product nào? Chẳng hạn.

Đó là những gì phần này của tài liệu nói về.

## Thêm File `.gitignore`

Trong bất kỳ thư mục nào của một Git repository, bạn có thể thêm file
`.gitignore` ("dot gitignore").

Đây là một textfile (file văn bản) đơn giản chứa danh sách các tên file
cần bỏ qua.

Giả sử mình có một dự án C build ra một executable gọi là "doom". Mình
không muốn check cái đó vào repo nguồn vì nó không phải là source (mã
nguồn), và nó chỉ là một binary (nhị phân) lớn chiếm nhiều dung lượng.

Nhưng khi mình lấy trạng thái, thật khó chịu khi thấy Git phàn nàn về
nó:

``` {.default}
$ git status
  On branch main
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
	  doom

  nothing added to commit but untracked files present (use "git
  add" to track)
```

Vì vậy mình chỉnh sửa file `.gitignore` trong thư mục đó và thêm dòng
này vào nó:

``` {.default}
doom
```

Bây giờ mình chạy status lại:

``` {.default}
$ git status
  On branch main
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
	  .gitignore

  nothing added to commit but untracked files present (use "git
  add" to track)
```

Ủa? Vẫn như vậy? Không hẳn! Đọc kỹ phần nhỏ!

Trước đây nó phàn nàn rằng `doom` chưa được tracked (theo dõi), nhưng
bây giờ nó không phàn nàn nữa. Vì vậy `.gitignore` đã hoạt động. Hoan
hô!

Nhưng Git đã tìm thấy một file chưa được tracked khác trong file
`.gitignore` mới tạo. Vì vậy chúng ta nên thêm cái đó vào repo.

Luôn đặt các file `.gitignore` của bạn vào repo trừ khi bạn có lý do
thuyết phục để không làm vậy. Bằng cách này chúng sẽ tồn tại trong tất
cả các clone của bạn, điều này tiện lợi.

``` {.default}
$ git add .gitignore
$ git commit -m Added
  [main 07582ad] Added
   1 file changed, 1 insertion(+)
   create mode 100644 .gitignore
```

Bây giờ chúng ta lấy trạng thái:

``` {.default}
$ git status
  On branch main
  nothing to commit, working tree clean
```

và chúng ta đã clear (trong sáng). File `doom` đó vẫn ở đó trong working
tree, nhưng Git không quan tâm đến nó vì nó ở trong `.gitignore`.

## Tôi Có Thể Chỉ Định Subdirectories trong `.gitignore` Không?

[i[`.gitignore` file-->With subdirectories]]

Được!

Bạn có thể cụ thể hoặc không cụ thể tùy thích với các file match (khớp).

Đây là `.gitignore` tìm kiếm một file rất cụ thể:

``` {.default}
subdir/subdir2/foo.txt
```

Điều đó sẽ khớp ở bất kỳ đâu trong repo. Nếu bạn muốn chỉ khớp một
file cụ thể từ repo root, bạn có thể thêm một slash ở đầu:

``` {.default}
/subdir/subdir2/foo.txt
```

Lưu ý rằng điều đó có nghĩa là `subdir` trong root (gốc) của _repo_,
không phải thư mục root của toàn bộ filesystem của bạn.

Nếu bạn đặt điều này vào `.gitignore` của mình:

``` {.default}
foo.txt
```

nó sẽ bỏ qua `foo.txt` trong tất cả các subdirectory của repo.


## Tôi Đặt `.gitignore` Ở Đâu?

[i[`.gitignore` file-->Location]]

Bạn có thể thêm file `.gitignore` vào bất kỳ subdirectory nào của repo.
Nhưng cách chúng hoạt động phụ thuộc vào nơi chúng ở.

Quy tắc là: *mỗi file `.gitignore` áp dụng cho thư mục chứa nó **và**
tất cả các subdirectory bên dưới nó*.

Vì vậy nếu bạn đặt một `.gitignore` trong thư mục gốc của repo có
`foo.txt` trong đó, mọi `foo.txt` duy nhất trong mọi subdirectory của
repo của bạn sẽ bị bỏ qua.

Dùng file `.gitignore` ở cấp cao nhất để chặn những thứ bạn biết bạn
không muốn **ở bất kỳ đâu** trong repo.

Nếu bạn thêm các file `.gitignore` bổ sung vào các subdirectory, chúng
chỉ áp dụng cho subdirectory đó và bên dưới.

Ý tưởng là bạn bắt đầu với bộ file bị bỏ qua áp dụng rộng rãi nhất
trong repo root, rồi ngày càng cụ thể hơn trong các subdirectory.

Đối với các repo đơn giản, bạn ổn chỉ với một `.gitignore` trong thư
mục gốc của repo.

Và chúng ta cũng sẽ nói về việc ghi đè các mục `.gitignore` sớm thôi.

## Wildcards

[i[`.gitignore` file-->Wildcards]]

Tôi có phải liệt kê riêng lẻ tất cả các file tôi không muốn trong
`.gitignore` không? Thật phiền phức!

May mắn thay Git hỗ trợ _wildcards_ (ký tự đại diện) trong việc đặt
tên file bị bỏ qua.

Ví dụ, nếu chúng ta muốn chặn tất cả các file kết thúc bằng extension
`.tmp` hoặc `.swp` (tên file temp của Vim), chúng ta có thể dùng wildcard
`*` ("splat") cho điều đó. Hãy tạo một `.gitignore` chặn những cái đó:

``` {.default}
*.tmp
*.swp
```

Và bây giờ bất kỳ file nào kết thúc bằng `.tmp` hoặc `.swp` sẽ bị bỏ
qua.

Hóa ra Vim có hai loại swap file, `.swp` và `.swo`. Vì vậy chúng ta có
thể thêm chúng như thế này?

``` {.default}
*.tmp
*.swo
*.swp
```

Tất nhiên! Điều đó hoạt động, nhưng có một cách ngắn hơn nơi bạn có
thể nói với Git để khớp bất kỳ ký tự nào trong một tập được đặt trong
ngoặc vuông. Điều này tương đương với trên:

``` {.default}
*.tmp
*.sw[op]
```

Bạn có thể đọc dòng cuối đó là, "Khớp các tên file bắt đầu bằng bất
kỳ chuỗi ký tự nào, theo sau là `.sw`, theo sau là `o` hoặc `p`."

## Negated (Phủ Định) Quy Tắc `.gitignore`

[i[`.gitignore` file-->Negated rules]]

Nếu `.gitignore` root của bạn đang bỏ qua các file `*.tmp` cho toàn bộ
repo thì sao? Không vấn đề.

Nhưng sau đó trong quá trình phát triển bạn có một subdirectory lồng sâu
có file `needed.tmp` mà bạn thực sự cần đưa vào Git.

Tin xấu, vì `*.tmp` bị bỏ qua ở cấp root trên tất cả các subdirectory
trong repo! Chúng ta có thể sửa không?

Được! Bạn có thể thêm một `.gitignore` mới vào subdirectory với
`needed.tmp` trong đó, với nội dung này:

``` {.default}
!needed.tmp
```

Điều này nói với Git, "Này, nếu bạn đang bỏ qua `needed.tmp` vì quy
tắc bỏ qua nào đó ở cấp cao hơn, xin hãy ngừng bỏ qua nó."

Vì vậy trong khi `needed.tmp` đang bị bỏ qua vì file bỏ qua ở root,
file cụ thể hơn này ghi đè điều đó.

Nếu bạn cần cho phép tất cả các file `.tmp` trong subdirectory này, bạn
có thể dùng wildcards:

``` {.default}
!*.tmp
```

Và điều đó sẽ làm cho tất cả các file `.tmp` trong subdirectory này
không bị bỏ qua.

## Làm Thế Nào để Bỏ Qua Tất Cả Các File Ngoại Trừ Một Số?

Bạn có thể dùng negated rules cho điều đó.

Đây là một `.gitignore` bỏ qua mọi thứ ngoại trừ các file gọi là `*.c`
hoặc `Makefile`:

``` {.default}
*
!*.c
!Makefile
```

Dòng đầu tiên bỏ qua mọi thứ. Hai dòng tiếp theo phủ định quy tắc đó
cho các file cụ thể đó.


## Lấy Các File `.gitignore` Có Sẵn

[i[`.gitignore` file-->Boilerplate]]

[fl[Đây là một repo|https://github.com/github/gitignore]] với rất nhiều
cái.

Nhưng bạn cũng có thể tự tạo theo nhu cầu. Dùng `git status` thường
xuyên để xem có file nào ở đó bạn muốn bỏ qua không.

Khi bạn tạo repo mới trên GitHub, nó cũng cho bạn tùy chọn chọn một
`.gitignore` đã được điền trước. **Cảnh báo!** Chỉ làm điều này nếu bạn
không có kế hoạch push một repo đã tồn tại vào repo GitHub mới tạo này.
Nếu bạn định làm vậy, `.gitignore` của GitHub sẽ cản trở.

[i[`.gitignore` file]>]
