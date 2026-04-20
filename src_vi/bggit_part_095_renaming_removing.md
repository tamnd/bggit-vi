# Đổi Tên và Xóa File

Đây là phần mở rộng của [trạng thái file](#file-states), vì vậy hãy chắc chắn đọc chương đó trước!

Ngoài ra, tôi sẽ dùng lẫn lộn các thuật ngữ _rename_ (đổi tên) và _move_ (di chuyển) để chỉ cùng một thứ. Move là khái niệm mạnh mẽ hơn một chút vì không chỉ đổi tên được mà còn có thể di chuyển file sang thư mục khác. Điều đáng lưu ý là lệnh để đổi tên là `git mv`.

## Đổi Tên File

[i[Move]<]

Bạn có thể dùng lệnh đổi tên của hệ điều hành để đổi tên file, nhưng nếu chúng nằm trong repo Git, tốt hơn là dùng `git mv` để Git hoàn toàn biết được.

Git khá khó chịu và không mấy hữu ích trong trường hợp này.

Hãy đổi tên `foo.txt` thành `bar.txt` và xem status:

``` {.default}
$ git mv foo.txt bar.txt
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  renamed:    foo.txt -> bar.txt
```

Vậy nó biết file đã được đổi tên, và file đã được đưa lên stage. Như thế này:

* **Unmodified** → `git mv foo.txt bar.txt` → **Staged** (as "renamed")

Và nếu kiểm tra, ta thấy file đã thực sự được đổi tên trong thư mục thành `bar.txt`.

Nếu ta commit tại đây, file sẽ được đổi tên trong repo. Xong.

[i[Move-->Reverting]]
Nhưng nếu ta muốn hoàn tác việc đổi tên thì sao?

Git gợi ý `git restore --staged` để giải cứu... Nhưng dùng tên file nào, tên cũ hay tên mới? Và rồi thì sao? Hóa ra mặc dù bạn *có thể* dùng `git restore` để hoàn tác điều này bằng cách theo sau nó với nhiều lệnh khác, trong trường hợp này bạn nên bỏ qua lời khuyên của Git và đọc phần sau.

## Hủy Đổi Tên File Khỏi Stage

[i[Move-->Unstaging]<]
Chỉ cần nhớ phần này: **cách dễ nhất để hoàn tác một rename đã Staged là đơn giản thực hiện rename ngược lại**.

Giả sử ta đã đổi tên và đến đây:

``` {.default}
$ git mv foo.txt bar.txt    # Rename foo.txt to bar.txt
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  renamed:    foo.txt -> bar.txt
```

Cách dễ nhất để hoàn tác thay đổi này là làm thế này:

``` {.default}
$ git mv bar.txt foo.txt    # Rename it back to foo.txt
$ git status
  On branch main
  nothing to commit, working tree clean
```

Và thế là xong.

Tóm lại, cách đổi tên file là:

* **Unmodified** → `git mv foo.txt bar.txt` → **Staged**
* **Staged** → `git commit` → **Unmodified**

Và cách thoát khỏi rename đã Staged là đổi tên ngược lại như cũ:

* **Staged** → `git mv bar.txt foo.txt` → **Unmodified**

[i[Move-->Unstaging]>]
[i[Move]>]

## Xóa File

[i[Remove]<]

Bạn có thể dùng lệnh xóa của hệ điều hành để xóa file, nhưng nếu chúng nằm trong repo git, tốt hơn là dùng `git rm` để Git hoàn toàn biết được.

Và những gì xảy ra có thể trông hơi kỳ lạ.

Giả sử ta có file `foo.txt` đã được commit. Nhưng ta quyết định xóa nó.

``` {.default}
$ git rm foo.txt
  rm 'foo.txt'         # This is Git's output
```

Lệnh này thực sự xóa file --- nếu bạn xem trong thư mục, nó không còn đó nữa.

Nhưng hãy kiểm tra status:

``` {.default}
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  deleted:    foo.txt
```

Vậy file đã bị xóa bây giờ ở Staged State, theo một nghĩa nào đó. Điều này có lý vì bây giờ có "sự khác biệt" giữa working tree (nơi file biến mất) và stage (nơi file vẫn còn).

Nếu ta commit ở đây, file sẽ bị xóa. Xong.

## Hủy Xóa File Khỏi Stage

[i[Remove-->Unstaging]<]
Nhưng nếu ta muốn hoàn tác việc staging của file đã bị xóa thì sao? Có gợi ý cách lấy nó lại với `git restore --staged`, như thường lệ.

Hãy thử:

``` {.default}
$ git restore --staged foo.txt
$ git status
  On branch main
  Changes not staged for commit:
    (use "git add/rm <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  deleted:    foo.txt

  no changes added to commit (use "git add" and/or "git commit -a")
```

Hmm. "Changes not staged for commit" là các file ở Modified State. Điều này có nghĩa là `foo.txt` đã "bị sửa đổi", đây là cách nói thân thiện hơn cho từ "đã bị xóa".

Vậy ta đã lùi từ Staged State về Modified State. Nhưng nhìn xung quanh, file vẫn biến mất! Tôi muốn lấy lại file của mình!

Ta muốn chuyển nó về Unmodified State, Git một lần nữa gợi ý cách làm trong status: `git restore`. Hãy thử:

``` {.default}
$ git restore foo.txt
$ git status
  On branch main
  nothing to commit, working tree clean
```

Git cho ta biết không có file Modified nào ở đây. Hãy xem thử:

``` {.default}
$ ls foo.txt
  foo.txt
```

Đó rồi, file đã trở về an toàn.

Vậy quy trình xóa một file đã commit là biến thể của những gì ta đã thấy:

* **Unmodified** → `git rm foo.txt` → **Staged**
* **Staged** → `git commit` → File bây giờ đã biến mất

Và bạn có thể hoàn tác việc xóa file (miễn là xóa chưa được commit) theo cách tương tự như hoàn tác bất kỳ trạng thái file nào khác:

* **Staged** → `git restore --staged foo.txt` → **Modified**
* **Modified** → `git restore foo.txt` → **Unmodified**

[i[Remove-->Unstaging]>]

## Lấy Lại File Từ Các Commit Trước

[i[Remove-->Unremoving from earlier commits]<]
Nếu có một file đã bị xóa từ lâu và bạn muốn lấy lại thì sao?

1. Tìm commit hash nơi file đó tồn tại.
2. Khôi phục file từ commit đó.

Có thể bạn biết tên file, nhưng nếu không, bạn sẽ phải lần lượt tra cứu log bằng `git log --name-only` cho đến khi tìm thấy.

Nhưng giả sử bạn biết tên file. Trong trường hợp này, bạn có thể lấy log cho file đã bị xóa như sau (giả sử file ta muốn là `foo.txt`):

``` {.default}
$ git log -- foo.txt
  commit 97bdb61727f7515d6953c965f56ef8329585f348
  Author: User <user@example.com>
  Date:   Sun Jan 12 11:08:33 2025 -0800

      Removed due to horrid commit messages

  commit 1c9bf4514ee90a0e65fb9b0a916765bb6c78dee6
  Author: User <user@example.com>
  Date:   Sun Jan 12 11:08:33 2025 -0800

      Add the barfsplant

  commit cc7a1940f13fca9092dbe9ce4a8e9012babd9314
  Author: User <user@example.com>
  Date:   Sun Jan 12 11:08:33 2025 -0800

      Initial splungification
```

Ở đó ta thấy lịch sử lẫy lừng của `foo.txt`.

Ta thấy nó bị xóa trong commit `97bdb`. Vậy không có điểm gì khi khôi phục từ đó (file đã biến mất rồi!). Nhưng commit _trước_ đó (`1c9bf`) là phiên bản mới nhất của `foo.txt` trước khi bị xóa. Đó có lẽ là cái ta muốn. (Hoặc có thể là commit cũ hơn nếu bạn muốn quay về xa hơn --- không có luật nào cấm điều đó.)

Và việc khôi phục khá đơn giản:

``` {.default}
$ git restore --source=1c9bf foo.txt
$ ls foo.txt
  foo.txt
```

Đây rồi! Nhưng ở trạng thái nào?

``` {.default}
$ git status
  On branch main
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
	  foo.txt
```

Nó thậm chí chưa được add. Vậy nếu bạn muốn đưa nó trở lại, bạn sẽ phải add và commit nó như thể nó là một file hoàn toàn mới.

[i[Remove-->Unremoving from earlier commits]>]

## Lưu Ý Về Việc Xóa Bí Mật

[i[Remove-->Secrets]<]

Ta đã thấy rằng một khi thứ gì đó được commit và xóa đi, vẫn có thể khôi phục lại.

Bây giờ, giả sử bạn đã commit một đoạn code trông như thế này:

``` {.default}
MASTER_PASSWORD_FOR_THE_ENTIRE_COMPANY=pencil
```

Và sau đó bạn mắc sai lầm khủng khiếp là push nó lên.

Điều đó đã đủ tệ rồi, nhưng giả sử còn tệ hơn nữa và bạn push nó lên một repo trên GitHub với quyền truy cập công khai.

Bây giờ cả thế giới đều có mật khẩu của bạn! Bạn xong rồi!

"Nhưng đợi đã! Tôi sẽ xóa nó thật nhanh rồi push và không ai biết đâu!"

Không. Công ty không thể chấp nhận rủi ro đó. Bất kỳ ai cũng có thể clone repo và nhìn vào lịch sử để lấy file đã bị xóa. Biện pháp duy nhất là đổi mật khẩu đó ngay lập tức. Trên toàn công ty. Đó là điều **bắt buộc** phải làm. Sếp của bạn không vui đâu.

> **Không bao giờ, KHÔNG BAO GIỜ commit bí mật vào Git.** Hãy dùng file
> dot-env[^e749] hoặc bất cứ thứ gì khác thay vì commit bí mật.

[^e749]: File dot-env (`.env`) là file chứa thông tin bí mật (như thông
    tin đăng nhập) mà không bao giờ được commit vào repo. Thường nó nằm
    trong `.gitignore` cho chắc chắn. Ai đó liên quan đến dự án sẽ dùng
    kênh liên lạc phụ để cho bạn biết nội dung của nó để bạn có thể xác
    thực đúng cách. Tôi đang dùng giọng nghiêm túc vì đây là vấn đề
    nghiêm túc!

Hãy giảm nhẹ mức độ vi phạm. Giả sử bạn đã push lên GitHub, nhưng đó là repo riêng tư. Vẫn còn khá tệ. Bạn phải tin tưởng tất cả những người có quyền truy cập, và tin tưởng rằng không có bản clone nào của repo sẽ rơi vào tay bất kỳ ai bên ngoài công ty hoặc nhân viên bất mãn nào. Biện pháp duy nhất vẫn là đổi mật khẩu.

Được rồi. Hãy làm nhẹ hơn *nữa*. Giả sử bạn đã commit mật khẩu vào repo, *nhưng bạn chưa push*.

Bây giờ ta có thể làm gì đó vì không có cơ hội nào người khác đã thấy code. Bạn chưa push nó, vì vậy không ai có thể đã pull nó. Nhưng ta sẽ không nói về điều đó ở đây; xem chương về [Sửa Đổi Commit](#amend) để sửa file trước khi push.

[i[Remove-->Secrets]>]

[i[Remove]>]
