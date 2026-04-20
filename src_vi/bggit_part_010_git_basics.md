# Kiến Thức Cơ Bản về Git

Chào mừng đến với _Beej's Guide to Git_ (Hướng dẫn Git của Beej)!

Tài liệu này có hai mục tiêu, không theo thứ tự ưu tiên nào:

1. Giúp bạn làm quen với cú pháp Git trên command line (dòng lệnh).
2. Giúp bạn xây dựng mental model (mô hình tư duy) mô tả cách Git lưu
   trữ thông tin của nó.

Mình cảm thấy mục tiêu thứ hai rất quan trọng để trở nên thành thạo dù
chỉ ở mức tối thiểu khi dùng Git, đó là lý do mình dành nhiều thời gian
nói về nó. Đúng là bạn có thể tồn tại với một cheat-sheet (bảng ghi nhớ)
các lệnh Git phổ biến, nhưng nếu muốn dùng công cụ này một cách tự tin
và hiệu quả tối đa, bạn cần học phần bên trong!

Và đúng, Git phức tạp. Có *rất nhiều* thứ trong đó. Nhưng giống như
nhiều công cụ phức tạp khác, có rất nhiều sức mạnh tiềm ẩn ở đó nếu
bạn bỏ thời gian để thành thạo.

## Git là gì?

Git là một _source code control system_ (hệ thống quản lý mã nguồn),
còn được gọi là _version control system_ (hệ thống kiểm soát phiên bản).

Rõ chưa? Ừ, chưa hẳn? Vậy hãy đi sâu hơn một chút!

Công việc chính của Git là lưu giữ một log (nhật ký) các _snapshot_
(ảnh chụp nhanh) về trạng thái hiện tại của toàn bộ mã nguồn trong một
cây thư mục cụ thể. Snapshot là trạng thái hiện tại của tất cả các file
được theo dõi tại một thời điểm nhất định. Nếu bạn muốn xem mã nguồn
của mình trông như thế nào vào thứ Tư tuần trước, bạn có thể quay ngược
thời gian và xem nó.

Ý tưởng là bạn sẽ thực hiện một số thay đổi (ví dụ để triển khai một
tính năng), rồi _commit_ (xác nhận) những thay đổi đó vào _source code
repo_ (repository --- kho mã nguồn) một khi tính năng đã sẵn sàng. Điều
này lưu các thay đổi vào repo và cho phép các cộng tác viên khác xem chúng.

Và nếu bạn thay đổi điều gì đó mà bạn không muốn, hay muốn xem cách
mọi thứ được triển khai trong quá khứ, bạn luôn có thể check out
(kiểm tra) một commit trước đó và nhìn lại.

Git lưu giữ lịch sử của tất cả các commit bạn đã từng thực hiện. Giả
sử không có gì phạm pháp đang xảy ra, điều này sẽ là một sự nhẹ nhõm
lớn cho bạn; nếu bạn vô tình xóa một đống code, bạn có thể nhìn vào
commit trước đó và lấy lại tất cả.

Nhưng đó chưa phải tất cả! Như chúng ta sẽ thấy, Git cũng hoạt động
tốt như một cơ chế backup (sao lưu) từ xa, và hoạt động tuyệt vời khi
cộng tác với một nhóm trên cùng một codebase (cơ sở mã).

### Định Nghĩa

* **Source Code Control System** (Hệ thống kiểm soát mã nguồn)/**Version Control System** (Hệ thống kiểm soát phiên bản): Phần mềm
  quản lý các thay đổi đối với một dự án phần mềm có thể bao gồm hàng
  nghìn file nguồn được chỉnh sửa bởi hàng trăm developer. Git là một
  source code control system. Có nhiều cái khác nữa.

* [i[Commit]] **Commit** (Xác nhận): Một thời điểm rõ ràng trong thời
  gian khi snapshot của nội dung tất cả các file nguồn được ghi lại
  trong source code control system. Rất, rất thường xuyên code đang ở
  trạng thái hoạt động khi commit được thực hiện; nói cách khác, commit
  đại diện theo một nghĩa nào đó là con dấu xác nhận rằng repo ở trạng
  thái này đang hoạt động tốt dù các thay đổi chưa hoàn chỉnh.
  
  Các ví dụ commit có thể là:

  * "Add feature *X* to the codebase" (Thêm tính năng X vào codebase)
  * "Fix bug *Y*" (Sửa lỗi Y)
  * "Merge other contributor's changes into the codebase" (Gộp thay đổi
    của cộng tác viên khác vào codebase)
  * "Partially complete the Spanish translation" (Hoàn thành một phần
    bản dịch tiếng Tây Ban Nha)

* **Repo**/**Source Code Repository** (Kho mã nguồn): Đây là nơi một
  dự án phần mềm cụ thể được lưu trữ trong source code control system.
  Thông thường mỗi dự án có repo riêng của nó. Ví dụ, bạn có thể "tạo
  một Git repo" để lưu một dự án mới mà bạn đang làm.

  Đôi khi repo nằm local (cục bộ) trên máy tính của bạn, và đôi khi
  chúng được lưu trữ trên các máy tính remote (từ xa) khác.

## GitHub là gì?

[i[GitHub]]

[fl[GitHub|https://github.com/]] **không phải** là Git.

## GitHub là gì?

[i[GitHub]]

Ồ, còn nữa à?

[GitHub](https://github.com/) là một website cung cấp giao diện frontend
cho nhiều tính năng Git, và một số tính năng dành riêng cho GitHub nữa.

Nó cũng cung cấp bộ nhớ lưu trữ từ xa cho repo của bạn, hoạt động như
một bản backup.

Tóm lại: GitHub là một web-based frontend (giao diện web) cho Git (cụ
thể là một cái hoạt động trên bản sao repo của bạn tại GitHub --- chờ
đợi chi tiết hơn về điều đó sau).

> [i[GitLab]][i[Gitea]]**Còn GitLab và Gitea thì sao?**
> [fl[GitLab|https://gitlab.com]] là đối thủ cạnh tranh của GitHub.
> [fl[Gitea|https://docs.gitea.com/]] là đối thủ mã nguồn mở cho phép
> bạn về cơ bản chạy một frontend kiểu GitHub trên server của riêng bạn.
> Không có thông tin nào trong số này là quan trọng ngay lúc này.

Bất kể bạn có repo nào trên GitHub, bạn cũng sẽ có các bản sao (được
gọi là _clone_) của những repo đó trên hệ thống local của bạn để làm
việc. Định kỳ, trong một workflow (quy trình làm việc) phổ biến, bạn
sẽ đồng bộ clone của repo với GitHub.

> **Bạn không cần GitHub.** Dù bạn có thể thường xuyên dùng GitHub,
> không có luật nào bắt bạn phải dùng. Bạn có thể thoải mái tạo và xóa
> các repo trên hệ thống local ngay cả khi bạn không kết nối Internet.
> Xem [Phụ lục: Tạo Sân Chơi](#making-playground) để biết thêm thông
> tin khi bạn đã thoải mái hơn với những kiến thức cơ bản.

## Workflow Git Cơ Bản Nhất

[i[Workflow-->Basic]]

Có một workflow cực kỳ phổ biến mà bạn sẽ dùng lặp đi lặp lại:

1. _Clone_ một _remote_ repo. Remote repo thường ở trên GitHub, nhưng
   không nhất thiết.
2. Thực hiện một số thay đổi local trong _working tree_ (cây làm việc)
   của bạn, nơi các file dự án nằm trên máy tính của bạn.
3. Thêm những thay đổi đó vào _stage_ (hay còn gọi là _index_).
4. _Commit_ những thay đổi đó.
5. _Push_ (đẩy) commit của bạn trở lại remote repo.
6. Quay lại Bước 2.

Đây không phải là workflow duy nhất; có những workflow khác cũng không
kém phổ biến.

### Định Nghĩa

* **Clone** (động từ): tạo một bản sao của remote repo ở local.

* **Clone** (danh từ): một bản sao local của remote repo.

* **Remote** (Từ xa): Trong Git, một bản sao của repo ở một vị trí khác.

* **Working Tree** (Cây làm việc): Thư mục mà bạn vào để chỉnh sửa và
  thay đổi các file của dự án. Nó được tạo khi bạn clone.

* **Stage** (Khu chuẩn bị): Trong Git, một nơi bạn thêm các bản sao
  của file vào để chuẩn bị cho commit. Commit sẽ bao gồm tất cả các
  file đã sửa đổi mà bạn đã đặt lên stage. Nó sẽ không bao gồm các
  file đã sửa đổi mà bạn chưa đặt lên stage.

* **Index** (Chỉ mục): Một tên ít phổ biến hơn cho stage.

## Cloning là gì?

[i[Clone]<]

Trước hết, một chút lý lịch.

Git là một loại _distributed_ version control system (hệ thống kiểm
soát phiên bản phân tán). Điều này có nghĩa là, không giống nhiều hệ
thống kiểm soát phiên bản khác, không có một cơ quan trung ương duy
nhất cho dữ liệu. (Mặc dù thông thường người dùng Git coi một trang như
GitHub theo nghĩa đó, một cách lỏng lẻo.)

Thay vào đó, Git có _clone_ của các repo. Đây là các bản sao hoàn chỉnh,
độc lập của toàn bộ lịch sử commit của repo đó. Bất kỳ clone nào cũng
có thể được tái tạo từ bất kỳ clone nào khác. Không cái nào mạnh hơn
cái nào khác.

Nhìn lại Workflow Git Cơ Bản Nhất ở trên, chúng ta thấy Bước 1 là
clone một repo hiện có.

Nếu bạn làm điều này từ GitHub, nghĩa là bạn đang tạo một bản sao
local của toàn bộ một repo GitHub hiện có.

Tạo một clone là một quá trình một lần, thường là vậy (mặc dù bạn có
thể tạo bao nhiêu cái tùy thích).

### Định Nghĩa

* **Distributed Version Control System** (Hệ thống kiểm soát phiên bản
  phân tán): Một VCS không có cơ quan trung ương về dữ liệu, và nhiều
  clone của một repo tồn tại.

  Điều này có nghĩa là sau khi bạn clone một repo, có hai cái: một cái
  ở remote, và một cái local trên máy tính của bạn.

  Những clone này hoàn toàn tách biệt và các thay đổi bạn thực hiện
  trên repo local sẽ không được phản ánh trong remote clone. Trừ khi
  bạn làm cho chúng tương tác một cách rõ ràng.

## Các Clone Tương Tác như Thế Nào?

Sau khi bạn tạo một clone, có hai thao tác chính bạn thường dùng:

* [i[Push]]**Push** (Đẩy): Lấy các commit local của bạn và upload
  (tải lên) chúng lên remote repo.

* [i[Pull]]**Pull** (Kéo): Lấy các commit remote và download (tải
  xuống) chúng về repo local của bạn.

Đằng sau hậu trường, có một quá trình đang diễn ra gọi là _merge_
(gộp), nhưng chúng ta sẽ nói thêm về điều đó sau.

Cho đến khi bạn push, các thay đổi local của bạn không hiển thị trên
remote repo.

Cho đến khi bạn pull, các thay đổi trên remote repo không hiển thị
trên repo local của bạn.

[i[Clone]>]

## Sử Dụng Git Thực Tế

[i[Workflow-->Basic]<]

Hãy bắt tay vào thực hành. Phần này giả định bạn đã cài đặt các công
cụ Git command line. Nó cũng thường giả định bạn đang chạy Unix shell
như Bash hoặc Zsh.

> **Lấy các shell này ở đâu?** Người dùng Linux/BSD/Unix và Mac đã có
> sẵn các shell này. Hoan hô!
>
> Khuyến nghị cho người dùng Windows là [fl[cài đặt và chạy Ubuntu với
> WSL|https://learn.microsoft.com/en-us/windows/wsl/]] để có cài đặt
> Linux ảo. Hoặc, nếu bạn chưa muốn đi sâu vào cái hố thỏ đó, hãy
> chạy Git Bash (đi kèm với Git).

Cho ví dụ này, chúng ta sẽ giả định chúng ta đã có một GitHub repo tồn
tại mà chúng ta sẽ clone.

Nhớ lại quy trình trong Workflow Git Cơ Bản Nhất, ở trên:

1. _Clone_ một _remote_ repo. Remote repo thường ở trên GitHub, nhưng
   không nhất thiết.
2. Thực hiện một số thay đổi local.
3. Thêm những thay đổi đó vào _stage_.
4. _Commit_ những thay đổi đó.
5. _Push_ commit của bạn trở lại remote repo.
6. Quay lại Bước 2.

### Bước 0: Thiết Lập Một Lần {#initial-setup}

[i[Configuration]]

"Chờ đã! Bạn không nói có Bước 0!"

Đúng vậy, một lần, trước khi bạn bắt đầu dùng Git, bạn nên cho nó biết
tên và địa chỉ email của bạn. Chúng sẽ được đính kèm vào các commit bạn
thực hiện với repo.

Bạn có thể thay đổi chúng bất kỳ lúc nào trong tương lai, và bạn thậm
chí có thể đặt chúng trên cơ sở từng repo. Nhưng bây giờ, hãy đặt chúng
globally (toàn cục) để Git không phàn nàn khi bạn thực hiện commit.

Bạn chỉ cần làm điều này một lần rồi không bao giờ cần lại (trừ khi bạn
muốn).

Gõ cả hai lệnh này vào command line, điền thông tin phù hợp.

> **Trong tài liệu này, những gì bạn gõ tại shell prompt được chỉ định
> bởi `$` ở đầu**. Đừng gõ `$`; chỉ gõ những gì theo sau nó. Shell
> prompt thực tế của bạn có thể là `%` hay `$` hay thứ gì khác, nhưng
> ở đây chúng ta dùng `$` để chỉ ra nó.

[i[Configuration-->Name and email]]

``` {.default}
$ git config set --global user.name "Your Name"
$ git config set --global user.email "your-email@example.com"
```

Nếu bạn cần thay đổi chúng trong tương lai, chỉ cần chạy lại các lệnh
đó.

> **Nếu bạn gặp lỗi với các lệnh trên** bạn có thể đang chạy phiên bản
> Git cũ hơn. Hãy thử lại chúng nhưng bỏ từ `set`. Hoặc tốt hơn là
> xem bạn có thể lấy phiên bản Git mới hơn không.

Cuối cùng, hãy đặt tên branch mặc định. Còn quá sớm để giải thích điều
đó có nghĩa là gì, nhưng hãy chạy lệnh này và đặt tên là `main`. Điều
này sẽ ngăn Git phàn nàn khi bạn tạo repo.

[i[Configuration-->Default branch]]

``` {.default}
$ git config set --global init.defaultBranch main
```

> **Một số repo dùng `master` cho tên branch mặc định thay vì `main`.**
> Thực ra đó là lựa chọn tùy ý, và người tạo repo có thể dùng bất cứ
> điều gì họ muốn. Chính Git gợi ý, "Các tên thường được chọn thay vì
> 'master' là 'main', 'trunk' và 'development'."
>
> Mình đề xuất dùng `main` vì nhiều lý do, không kém gì việc đó là
> những gì GitHub dùng, nhưng tùy bạn. Trong tài liệu này mình sẽ dùng
> `main`.

### Bước 1: Clone một Repo Hiện Có

[i[Clone]]

Hãy clone một repo! Đây là một repo mẫu bạn thực sự có thể dùng. Đừng
lo --- bạn không thể làm hỏng bất cứ điều gì trên remote repo ngay cả
khi (và vì) bạn không sở hữu nó.

> **Như đã nói trước, đây không phải là workflow duy nhất.** Đôi khi
> người ta tạo repo local trước, thêm một số commit, sau đó tạo remote
> repo và push những commit đó. Nhưng cho ví dụ này, chúng ta sẽ giả
> định remote repo tồn tại trước, mặc dù đây không phải là yêu cầu bắt
> buộc.

Chuyển vào một thư mục con nơi bạn muốn clone được tạo. Lệnh này sẽ
tạo một thư mục con mới từ đó để chứa tất cả các file repo.

(Trong ví dụ, bất cứ thứ gì bắt đầu bằng `$` đại diện cho shell prompt
cho biết đây là input (đầu vào), không phải output (đầu ra). Đừng gõ
`$`; chỉ gõ phần sau nó.)

``` {.default}
$ git clone https://github.com/beejjorgensen/git-example-repo.git
```

Bạn sẽ thấy một số output tương tự như sau:

``` {.default}
Cloning into 'git-example-repo'...
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 10 (delta 2), reused 9 (delta 1), pack-reused 0
remote: (from 0)
Receiving objects: 100% (10/10), done.
Resolving deltas: 100% (2/2), done.
```

Chúc mừng! Bạn có một clone của repo. Hãy nhìn qua:

``` {.default}
$ cd git-example-repo
$ ls -la
```

Và chúng ta thấy một số file:

``` {.default}
total 16
drwxr-xr-x    5 beej  staff   160 Jan 18 13:35 .
drwxr-xr-x  106 beej  staff  3392 Jan 18 13:35 ..
drwxr-xr-x   12 beej  staff   384 Jan 18 13:35 .git
-rw-r--r--    1 beej  staff   162 Jan 18 13:35 README.md
-rwxr-xr-x    1 beej  staff    75 Jan 18 13:35 hello.py
```

Có hai file trong repo này: `README.md` và `hello.py`.

> [i[`.git` directory]]**Thư mục `.git` có ý nghĩa đặc biệt;**
> đó là thư mục nơi Git lưu giữ tất cả metadata (siêu dữ liệu) và
> commit của nó. Bạn có thể nhìn vào đó, nhưng bạn không cần phải làm
> vậy. Nếu bạn nhìn vào, đừng thay đổi bất cứ điều gì. Điều duy nhất
> làm cho một thư mục trở thành Git repo là sự hiện diện của một thư
> mục `.git` hợp lệ bên trong nó.

[i[Status]]
Hãy hỏi Git trạng thái hiện tại của repo local là gì:

``` {.default}
$ git status
```

Cho chúng ta:

``` {.default}
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

Có rất nhiều thông tin ở đây, thật ngạc nhiên.

Chúng ta chưa nói về branching (phân nhánh) nhưng điều này cho chúng ta
biết chúng ta đang ở branch `main`. Ổn cho bây giờ.

Nó cũng cho biết branch này đang up to date (cập nhật) với một branch
có tên [i[Remote-->`origin`]] `origin/main`. Một branch trong Git chỉ
là một tham chiếu đến một commit nhất định đã được thực hiện, như một
tờ Post-It gắn vào commit đó. (Nhớ lại rằng commit là snapshot của code
repo tại một thời điểm nào đó.)

Chúng ta không muốn bị cuốn vào những chi tiết phức tạp của branching
ngay bây giờ, nhưng hãy chịu đựng mình thêm vài đoạn văn.

`origin` là alias (bí danh) cho remote repository mà chúng ta ban đầu
clone từ đó, vì vậy `origin/main` tương ứng với "branch `main` trên repo
bạn ban đầu clone từ đó"[^a7cb].

[^a7cb]: Chúng ta đang lướt qua một chủ đề quan trọng ở đây mà chúng ta
    sẽ quay lại sau gọi là _remote tracking branches_ (các branch theo
    dõi từ xa).

Có một điều quan trọng cần chú ý ở đây: có hai branch `main`. Có branch
`main` trên repo local của bạn, và có một branch `main` tương ứng trên
remote repo (`origin`)[^2d0c].

[^2d0c]: Và một lần nữa chúng ta đang làm một số hand-waving (giải thích
    qua loa). Thực ra có ba branch. Hai trong số chúng, `main` và
    `origin/main` ở trên clone local của bạn. Và có một `main` thứ ba
    trên remote `origin` mà `origin/main` của bạn đang _theo dõi_. Hãy
    thoải mái bỏ qua chi tiết này cho đến khi chúng ta đến chương về
    remote tracking branch.

Nhớ cách các clone tách biệt nhau không? Nghĩa là, các thay đổi bạn
thực hiện trên một clone không tự động hiển thị trên cái kia? Đây là
dấu hiệu của điều đó. Bạn có thể thực hiện thay đổi cho branch `main`
local của mình, và những điều này sẽ không ảnh hưởng đến branch `main`
của remote. (Ít nhất là không cho đến khi bạn push những thay đổi đó!)

Cuối cùng, nó đề cập rằng chúng ta đang cập nhật với phiên bản mới nhất
của `main` trên `origin` (mà chúng ta biết), và không có gì để commit
vì không có thay đổi local. Chúng ta chưa biết điều đó có nghĩa là gì,
nhưng tất cả nghe có vẻ là tin tốt mơ hồ.

### Bước 2: Thực Hiện Một Số Thay Đổi Local

Hãy chỉnh sửa một file và thực hiện một số thay đổi.

> **Lần nữa, đừng lo về việc làm hỏng remote repo** --- bạn không có
> quyền làm điều đó. Sự an toàn của bạn được đảm bảo hoàn toàn từ góc
> độ Git.

Nếu bạn đang dùng VS Code, bạn có thể chạy nó trong thư mục hiện tại
như sau:

``` {.default}
$ code .
```

Nếu không, hãy mở code trong editor (trình soạn thảo) yêu thích của
bạn, mà thừa nhận đi, là
[fl[Vim|https://www.vim.org/]].

Hãy thay đổi `hello.py`:

Trước đây là:

``` {.py .numberLines}
#!/usr/bin/env python

print("Hello, world!")
print("This is my program!")
```

nhưng hãy thêm một dòng để nó trở thành:

``` {.py .numberLines}
#!/usr/bin/env python

print("Hello, world!")
print("This is my program!")
print("And this is my modification!")
```

Và lưu file đó.

[i[Status]]
Hãy hỏi Git trạng thái hiện tại là gì.

``` {.default}
$ git status
  On branch main
  Your branch is up to date with 'origin/main'.

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   hello.py

  no changes added to commit (use "git add" and/or "git commit -a")
```

Điều này cho chúng ta biết một vài điều quan trọng.

Đầu tiên, Git đã phát hiện ra rằng chúng ta đã sửa đổi một file, cụ thể
là `hello.py`, mà chúng ta đã làm.

Nhưng nó cũng nói rằng `no changes added to commit` (không có thay đổi
nào được thêm vào commit, tức là "không có gì để tạo commit"). Điều đó
có nghĩa là gì?

Điều đó có nghĩa là chúng ta chưa thêm bất kỳ file nào đã sửa đổi vào
_stage_ (khu chuẩn bị). Nhớ lại rằng stage là nơi chúng ta có thể đặt
các mục mà chúng ta muốn đưa vào commit tiếp theo. Hãy thử điều đó.

#### Bước 2.1: Xem Lại Các Thay Đổi Của Bạn

[i[Diff]]
Chúng ta sẽ tạm thời rẽ sang để giới thiệu ngắn gọn một công cụ tùy
chọn mới: `git diff` (viết tắt của "difference" --- sự khác biệt, dù
chúng ta vẫn đọc là "diff").

Nếu bạn thực hiện một số thay đổi đối với các file và cần nhắc nhở về
tất cả những thứ bạn đã thay đổi, bạn có thể chạy lệnh này để xem. Tuy
nhiên, hãy cảnh báo trước, output thì... *khó hiểu*.

Hãy thử.

``` {.default}
$ git diff
  diff --git a/hello.py b/hello.py
  index 9db78d2..1187d32 100755
  --- a/hello.py
  +++ b/hello.py
  @@ -2,3 +2,4 @@
 
   print("Hello, world!")
   print("This is my program!")
  +print("And this is my modification!")
```

Ma thuật gì vậy trời? Nếu may mắn, nó được tô màu cho bạn theo (quy
ước) các dòng được thêm màu xanh lá và các dòng bị xóa màu đỏ.

Bây giờ, chỉ cần chú ý một vài điều:

1. Tên file. Chúng ta thấy thay đổi này là với `hello.py`.
2. Dòng có `+` ở đầu. Điều này chỉ ra một dòng được thêm.

Một `-` ở đầu dòng sẽ cho biết dòng đó bị xóa. Và các dòng đã thay đổi
thường được hiển thị như dòng cũ bị xóa và dòng mới được thêm.

Cuối cùng, nếu bạn muốn xem diff cho những thứ bạn đã thêm vào stage
rồi (ở bước tiếp theo), bạn có thể chạy `git diff --staged`.

Chúng ta sẽ đi sâu hơn về diff sau, nhưng mình muốn giới thiệu nó ở đây
vì nó hữu ích.

### Bước 3: Thêm Thay Đổi vào Stage

[i[Stage]<]
[i[Add]<]

Thông báo trạng thái Git ở trên đang cố gắng giúp chúng ta. Nó nói:

``` {.default}
no changes added to commit (use "git add" and/or "git commit -a")
```

Nó gợi ý rằng `git add` sẽ thêm thứ vào stage --- và đúng vậy.

Bây giờ chúng ta, các developer, biết rằng chúng ta đã sửa đổi `hello.py`,
và chúng ta muốn tạo một commit phản ánh các thay đổi đối với file đó.
Vì vậy, chúng ta cần phải thêm nó vào stage trước để có thể tạo commit.

Hãy làm với `git add`:

``` {.default}
$ git add hello.py
$ git status
  On branch main
  Your branch is up to date with 'origin/main'.

  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   hello.py
```

Bây giờ nó đã thay đổi từ "Changes not staged for commit" sang "Changes
to be committed", vì vậy chúng ta đã sao chép thành công `hello.py` vào
stage!

> **Cũng có một thông báo hữu ích ở đó về cách _unstage_ file.** Giả
> sử bạn vô tình thêm nó vào stage và bạn thay đổi ý định và không muốn
> đưa nó vào commit nữa. Bạn có thể chạy
>
> ``` {.default}
> $ git restore --staged hello.py
> ```
> <!-- ` vim markdown highlight bug workaround -->
>
> và điều đó sẽ thay đổi nó trở lại trạng thái "Changes not staged for
> commit".

[i[Stage]>]
[i[Add]>]

### Bước 4: Commit Những Thay Đổi Đó

[i[Commit]<]

Bây giờ chúng ta đã có thứ gì đó được sao chép lên stage, chúng ta có
thể tạo commit. Nhớ lại rằng commit chỉ là snapshot về trạng thái của
repo với các file đã sửa đổi trên stage. Các file đã sửa đổi không có
trên stage sẽ không được đưa vào snapshot. Các file chưa sửa đổi được
tự động đưa vào snapshot.

Nói ngắn gọn, snapshot commit sẽ chứa tất cả các file chưa sửa đổi mà
Git hiện theo dõi **cộng với** các file đã sửa đổi đang trên stage.
(Git chỉ không hiển thị tất cả các file chưa sửa đổi với `status` vì
output sẽ hoàn toàn vô dụng.)

Hãy làm:

``` {.default}
$ git commit -m "Add another print line"
  [main 0e1ad42] Add another print line
   1 file changed, 1 insertion(+)
```

> **Flag `-m` cho phép bạn chỉ định commit message.** Nếu bạn không
> dùng `-m`, bạn sẽ bị đẩy vào một editor, có thể là Nano hoặc Vim, để
> chỉnh sửa commit message. Nếu bạn không quen với những cái đó, xem
> [Thoát Khỏi Editor](#editor-get-out) để được giúp đỡ.
>
> **Nếu bạn vào editor, hãy biết rằng mỗi dòng trong commit message bắt
> đầu bằng `#` là comment** bị bỏ qua cho mục đích của commit. Hơi kỳ
> là commit message là comment về commit, rồi bạn có thể có các dòng
> comment-out trong comment, nhưng mình không đặt ra quy tắc!

Và đó là tin tốt! Hãy kiểm tra trạng thái:

``` {.default}
$ git status
  On branch main
  Your branch is ahead of 'origin/main' by 1 commit.
    (use "git push" to publish your local commits)

  nothing to commit, working tree clean
```

"Nothing to commit, working tree clean" (Không có gì để commit, working
tree sạch) có nghĩa là chúng ta không có thay đổi local nào trên branch
của mình.

> **Hóa ra có một shortcut (lối tắt) tùy chọn ở đây.** Nếu bạn đã sửa
> đổi một file, bạn có thể commit nó trực tiếp (mà không cần thêm vào
> stage!) bằng cách đặt tên nó trên command line.
>
> Giả sử bạn đã sửa đổi `foo.txt` nhưng chưa thêm nó. Bạn có thể:
>
> ``` {.default}
> $ git commit -m "jerbify the flurblux" foo.txt
> ```
> 
> <!-- ` -->
> Và điều đó sẽ tạo commit trực tiếp, bỏ qua bước thêm-vào-stage.
> Nhưng bạn chỉ có thể làm điều này với các file mà repo đã biết đến,
> tức là chúng không phải là "untracked" (chưa được theo dõi).
>
> Bạn có thể chỉ định nhiều file ở đây, hoặc một thư mục. Ngoài ra, điều
> này không ảnh hưởng đến các file đã có trên stage.

Nhưng nhìn kìa! Trạng thái cho biết chúng ta đang "ahead of 'origin/main'
by 1 commit" (đi trước 'origin/main' 1 commit)! Điều này có nghĩa là
lịch sử commit local của chúng ta trên branch `main` có một commit mà
lịch sử commit remote trên branch `main` của nó không có.

Điều đó có ý nghĩa --- remote repo là một clone và vì vậy nó độc lập
với repo local của chúng ta trừ khi chúng ta cố tình cố gắng đồng bộ
chúng. Nó không tự động biết rằng chúng ta đã thực hiện thay đổi cho
repo local.

Và Git đang hữu ích cho chúng ta biết để chạy `git push` nếu chúng ta
muốn cập nhật remote repo để nó cũng có các thay đổi của chúng ta.

Vì vậy hãy thử làm điều đó. Hãy push các thay đổi local của chúng ta
lên remote repo.

[i[Commit]>]

### Bước 5: Push Thay Đổi Của Bạn lên Remote Repo

[i[Push]<]

Hãy push các thay đổi local của chúng ta lên remote repo:

``` {.default}
$ git push
```

Và điều đó tạo ra:

``` {.default}
Username for 'https://github.com':
```

Ối --- rắc rối đến rồi. Hãy thử nhập thông tin đăng nhập:

``` {.default}
Username for 'https://github.com': my_username
Password for 'https://beejjorgensen@github.com': [my_password]
remote: Support for password authentication was removed on August
        13, 2021.
remote: Please see https://docs.github.com/en/get-started/getting-
        started-with-git/about-remote-repositories#cloning-with-
        https-urls for information on currently recommended modes
        of authentication.
fatal: Authentication failed for 'https://github.com/beejjorgensen/
       git-example-repo.git/'
```

Ôi thôi, không hoạt động gì cả. Phần lớn là vì bạn không có quyền ghi
vào repo đó vì bạn không phải là chủ sở hữu. Và đáng chú ý là hỗ trợ
xác thực bằng mật khẩu dường như đã bị xóa vào năm 2021, mà theo kiểm
tra cuối cùng của mình, là đã xảy ra trong quá khứ.

Vậy chúng ta làm gì? Trước tiên, chúng ta nên là chủ sở hữu của GitHub
repo mà chúng ta đã clone và điều đó sẽ giải quyết một số vấn đề về
quyền. Thứ hai, chúng ta cần tìm cách khác để xác thực bản thân với
GitHub mà không phải mật khẩu thông thường.

Hãy thử điều đó trong phần tiếp theo.

[i[Push]>]
[i[Workflow-->Basic]>]
