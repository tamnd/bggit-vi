# Trạng Thái File {#file-states}

[i[File States]<]

Ta đã nói nhiều về điều này trong các chương trước.

Nếu bạn tạo một file mới, bạn phải `git add` nó lên stage (vùng chuẩn bị) trước khi commit.

Nếu bạn sửa đổi một file, bạn nên `git add` nó lên stage trước khi commit.

Nếu bạn thêm file `foo.txt` vào stage, bạn có thể đưa nó ra khỏi stage trước khi commit bằng `git restore --staged foo.txt`.

Vậy rõ ràng file có thể tồn tại ở nhiều "trạng thái" khác nhau và ta có thể di chuyển chúng giữa các trạng thái đó.

Để biết file đang ở trạng thái nào và gợi ý cách "hoàn tác" từ trạng thái đó, `git status` là người bạn tốt nhất của bạn (ngoại trừ trường hợp đổi tên, nhưng ta sẽ bàn thêm về cái mớ rắc rối đó sau).

## Các File trong Git Có Thể Ở Những Trạng Thái Nào?

Có bốn trạng thái: **Untracked** (chưa được theo dõi), **Unmodified** (chưa sửa đổi), **Modified** (đã sửa đổi), và **Staged** (đã staging).

* [i[File States-->Untracked]] **Untracked**: Git không biết gì về file này (ví dụ bạn vừa tạo nó trong working tree và chưa add). Git sẽ bỏ qua nó, nhưng bạn sẽ thấy nó trong status.

  Bạn có thể để Git nhận biết file này bằng cách đưa nó sang Staged State với `git add`.

  Hoặc bạn có thể đơn giản xóa file nếu không muốn nó tồn tại, hoặc thêm nó vào `.gitignore` nếu muốn để file ở đó nhưng vẫn muốn Git bỏ qua nó.

* [i[File States-->Unmodified]] **Unmodified**: Git biết về file này và nó nằm trong repo. Nhưng bạn chưa thực hiện thay đổi gì kể từ lần commit cuối.

  Bạn có thể chuyển file này sang Modified State bằng cách thực hiện thay đổi trong file (và lưu).

  Bạn có thể xóa file này bằng `git rm`, lệnh này sẽ chuyển file đã xóa sang Staged State. (Đợi đã --- xóa file thì lại đưa lên stage? Đúng vậy! Ta sẽ bàn thêm sau.)

* [i[File States-->Modified]] **Modified**: Git biết về file này và biết rằng bạn đã thay đổi nó. File đã sẵn sàng để bạn staging những thay đổi đó hoặc hoàn tác chúng.

  Bạn có thể chuyển file sang Staged State bằng `git add`.

  Bạn có thể chuyển file sang Unmodified State (bỏ qua những thay đổi của bạn) bằng `git restore`.

* [i[File States-->Staged]] **Staged**: File đã sẵn sàng để đưa vào commit tiếp theo.

  Bạn có thể chuyển sang Unmodified State bằng cách thực hiện commit với `git commit`.

  Bạn có thể đưa file ra khỏi stage và trở về Modified State bằng `git restore --staged`.

[i[Workflow-->File states]] Một file thường đi qua quá trình này để được thêm vào repo:

1. Người dùng tạo một file mới và lưu nó. File này ở trạng thái **Untracked**.

2. Người dùng add file bằng `git add`. File bây giờ ở trạng thái **Staged**.

3. Người dùng commit file bằng `git commit`. File bây giờ ở trạng thái **Unmodified** và là một phần của repo, sẵn sàng để dùng.

Sau khi file đã vào repo, vòng đời điển hình của file chỉ khác ở bước đầu tiên:

1. Người dùng thay đổi file và lưu. File bây giờ ở trạng thái **Modified**.

2. Người dùng add file bằng `git add`. File bây giờ ở trạng thái **Staged**.

3. Người dùng commit file bằng `git commit`. File bây giờ ở trạng thái **Unmodified** và là một phần của repo, sẵn sàng để dùng.

Hãy nhớ rằng một commit thường là một gói các thay đổi khác nhau cho các file khác nhau. Tất cả những file đó sẽ được add vào stage trước một commit duy nhất.

Dưới đây là danh sách một phần các cách thay đổi trạng thái:

* **Untracked** → `git add foo.txt` → **Staged** (as "new file")
* **Modified** → `git add foo.txt` → **Staged**
* **Modified** → `git restore foo.txt` → **Unmodified**
* **Unmodified** → edit `foo.txt` → **Modified**  (with your favorite editor)
* **Staged** → `git commit` → **Unmodified**
* **Staged** → `git restore --staged` → **Modified**

Một lần nữa, `git status` thường sẽ cho bạn lời khuyên về cách hoàn tác một thay đổi trạng thái.

## Từ Unmodified sang Untracked

[i[Untracking files]]

Một biến thể của `git rm` bảo Git xóa file khỏi repo nhưng vẫn giữ nguyên file trong working tree. Có thể bạn muốn giữ file đó nhưng không muốn Git theo dõi nó nữa.

Để làm điều này, bạn dùng tùy chọn `--cached`.

Đây là một ví dụ xóa file `foo.txt` khỏi repo nhưng vẫn giữ nó trong working tree:

``` {.default}
$ ls
  foo.txt

$ git rm --cached foo.txt
  rm 'foo.txt'

$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  deleted:    foo.txt

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
	  foo.txt

$ ls
  foo.txt
```

Bạn thấy trong đầu ra `status` rằng Git đã staging file để xóa, nhưng cũng đề cập rằng file tồn tại và đang ở trạng thái untracked. Và lệnh `ls` tiếp theo cho thấy file vẫn còn đó.

Tại thời điểm này, bạn có thể commit và file sẽ ở trạng thái Untracked.

## File Ở Nhiều Trạng Thái Cùng Lúc

[i[File States-->Multiple]]
Thực ra file có thể tồn tại ở nhiều trạng thái cùng lúc. Nói cho chính xác hơn, có thể có các bản sao của file ở các trạng thái khác nhau cùng một lúc. Chẳng hạn, bạn có thể có một phiên bản file trên stage, và một phiên bản khác của file đó, với những sửa đổi khác nhau, trong working tree *cùng một lúc*. Về mặt kỹ thuật đây thực sự là những file khác nhau vì chúng không chứa cùng dữ liệu.

Chỉ cần nhớ rằng khi bạn stage một file, nó thực sự stage một **bản sao** của file đó tại thời điểm đó. Không có gì ngăn bạn thực hiện sửa đổi khác vào file trong working tree và kết thúc như thế này, khi một phiên bản file trên stage sẵn sàng để commit, và một phiên bản khác ở trong working tree với những thay đổi bổ sung chưa được stage:

``` {.default}
$ git status
  On branch main
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
	  modified:   foo.txt

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working
    directory)
	  modified:   foo.txt
```

Bạn có thể ghi đè phiên bản trên stage bằng cách add lại. Và các biến thể khác nhau của `restore` có thể thay đổi file theo nhiều cách. Hãy tra cứu các tùy chọn `--staged` và `--worktree` của `git restore`.

Tôi sẽ để việc di chuyển file giữa các trạng thái đồng thời này như một bài tập cho bạn đọc, nhưng tôi muốn bạn ít nhất biết đến điều này.

[i[File States]>]
