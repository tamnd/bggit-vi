# GitHub: Fork và Pull Request

[i[Fork]<]
[i[Pull requests]<]

Với nhiều dự án bạn tham gia, có thể bạn đã có quyền ghi (write permission) vào
repo chính mà cả nhóm đang dùng. Tức là bạn đã được thêm vào làm cộng tác viên
và có thể push thẳng lên luôn.

Nếu vậy, bạn không cần fork (sao chép) repo GitHub hay tạo pull request. Cứ
commit và push như thường thôi.

Nhưng nếu bạn muốn thay đổi một repo trên GitHub mà bạn không có quyền ghi thì
sao? Điều này xảy ra khi bạn fork một repo và muốn thay đổi nó. Bạn có thể ghi
lên fork của mình, nhưng không được ghi lên repo gốc mà bạn fork từ đó. Vậy làm
thế nào để đưa những thay đổi từ fork của bạn vào repo gốc?

Cùng tìm hiểu nào.

Một ***fork*** (bản sao) là một bản clone của repo GitHub của người khác mà bạn
đã tạo trên GitHub bằng lệnh "Fork" của họ. Đây là bản clone thông thường, chỉ
khác là GitHub lưu lại thông tin để biết bạn đã fork từ repo nào.

***Upstream*** là tên thông lệ của remote (kho từ xa) mà bạn đã fork từ đó. Tôi
biết điều này mâu thuẫn với một số định nghĩa khác của "upstream". Nhưng trong
chương này, trong ngữ cảnh fork, hãy giả định nó mang nghĩa này.

Một ***pull request*** (hay viết tắt là "PR") là cách để bạn đề xuất những thay
đổi bạn đã thực hiện trên fork của mình cho chủ sở hữu repo gốc.

> **Fork và Pull Request là tính năng của GitHub, không phải của Git.** Đây là
> tính năng bổ sung mà GitHub đã triển khai trên trang web của họ để bạn sử dụng.

Hãy lấy ví dụ: bạn tìm thấy một dự án mã nguồn mở mình thích và phát hiện có
lỗi trong đó. Bạn không có quyền ghi lên repo GitHub của dự án, vậy làm sao để
thay đổi nó?

[i[Fork-->Process]]

Quy trình để ai đó tạo pull request là:

1. Trên GitHub, fork repo đó. Giờ bạn có bản clone của riêng mình.
2. Clone repo của bạn về máy local. Giờ bạn có hai bản clone: fork của bạn trên
   GitHub và bản clone trên máy local. (Và bạn sở hữu cả hai.)
3. Thực hiện sửa lỗi trên máy local và kiểm tra.
4. Push bản sửa lỗi lên fork GitHub của bạn.
5. Trên GitHub, tạo pull request. Thao tác này thông báo cho chủ upstream biết
   rằng bạn có thay đổi muốn họ merge vào.
6. Trên GitHub, chủ upstream xem xét PR của bạn và quyết định có muốn merge không.
   Nếu có, họ merge. Nếu không, họ comment và yêu cầu chỉnh sửa, hoặc xóa PR.
7. Lúc này, nếu đã xong, bạn có thể tùy ý xóa fork của mình.

Thử đi nào! Cứ tự nhiên tạo PR trên repo mẫu của tôi, dùng ở phía dưới. Tôi sẽ
xóa chúng đi (sẽ không được merge); đừng buồn---tôi chỉ là không có thời gian
xem xét hết.

## Tạo Fork

[i[Fork-->Creating]<]

Truy cập [fl[repo test của
tôi|https://github.com/beejjorgensen/git-example-repo]] và làm thế này:

* Ở góc trên bên phải có một nút "Fork". Nhấn vào đó.
* Dưới mục "Owner", chọn tên người dùng của bạn.
* Dưới mục "Repository name", giữ tên mặc định hoặc đặt tên mới.
* Tùy chọn: nếu repo có nhiều nhánh và bạn muốn có chúng trong fork, bỏ chọn
  ô "Copy the main branch only". Bạn có thể lấy các nhánh đó thủ công sau nếu
  không làm bước này.
* Nhấn nút "Create fork".

> **Thao tác này hoàn toàn vô hại.** Nghĩa là bạn đã tạo fork của mình nhưng
> chủ gốc không hề hay biết. Bạn có thể xóa nó mà không gây hại gì cho repo
> gốc. Nhớ rằng fork là bản clone trên GitHub mà bạn sở hữu, độc lập với repo
> gốc.

Lúc này, bạn sẽ thấy trang dự án của fork, và dòng chú thích nhỏ trên trang
ghi: "forked from beejjorgensen/git-example-repo".

Và giờ chúng ta có phiên bản repo đó trên GitHub của riêng mình để tùy ý sử
dụng.

Chúng ta có thể clone bình thường, pull, push, xóa repo, v.v. Chủ repo gốc sẽ
không biết---những thay đổi của chúng ta chỉ ảnh hưởng đến repo của mình. Sau
này chúng ta sẽ xem cách tạo pull request để thử đưa thay đổi vào repo upstream
gốc.

[i[Fork-->Creating]>]

## Thực Hiện Thay Đổi

Hãy thực hiện một số thay đổi. Đầu tiên, chúng ta phải clone *repo của mình*
(tức là clone fork mà chúng ta đã tạo) về máy local.

Vậy nhấn vào nút "Code" như thường và chọn đường dẫn SSH để clone (hoặc dùng
GitHub CLI nếu bạn đang dùng cái đó).

``` {.default}
$ git clone git@github.com:user/git-example-repo.git
  Cloning into 'git-example-repo'...
  remote: Enumerating objects: 4, done.
  remote: Counting objects: 100% (4/4), done.
  remote: Compressing objects: 100% (3/3), done.
  remote: Total 4 (delta 0), reused 4 (delta 0), pack-reused 0
  Receiving objects: 100% (4/4), done.
```

Sau đó bạn có thể `cd` vào thư mục đó và xem các file trong đó.

``` {.default}
$ cd git-example-repo
$ ls
  hello.py    README.md
```

Hãy sửa `hello.py` thành như sau:

``` {.py .numberLines}
#!/usr/bin/env python

print("Hello, world!")
print("This is my program!")
print("This is my modification")
```

Và hãy add, commit, rồi push.

``` {.default}
$ git add hello.py
$ git commit -m "modified"
  [main 5d3fe49] modified
   1 file changed, 1 insertion(+)
$ git push
  Enumerating objects: 5, done.
  Counting objects: 100% (5/5), done.
  Delta compression using up to 8 threads
  Compressing objects: 100% (3/3), done.
  Writing objects: 100% (3/3), 1.02 KiB | 1.02 MiB/s, done.
  Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
  To github.com:user/git-example-repo.git
     4332527..5d3fe49  main -> main
```

Một lần nữa, thao tác này chỉ push lên fork của chúng ta, không phải upstream.
Bạn có thể xem trang fork của mình trên GitHub và thấy thay đổi ở đó.

## Đồng Bộ Upstream với Fork của Bạn

[i[Fork-->Syncing with Upstream]<]

Bạn đã sẵn sàng tạo PR chưa? Khoan đã một chút!

Nếu chủ upstream đã thực hiện thay đổi trên repo của họ trong thời gian đó thì
sao? Bạn có muốn đảm bảo code của mình hoạt động với phiên bản mới nhất của code
họ không?

Tất nhiên rồi.

Trên trang fork của bạn, bạn có thể thấy nút "Sync fork" có thể kéo xuống.

Nếu bạn kéo xuống và thấy "This branch is not behind the upstream" (Nhánh này
không chậm hơn upstream), chúc mừng! Bạn đã cập nhật! Cứ tạo PR, như hướng dẫn
ở phần tiếp theo.

Nếu bạn kéo xuống và thấy "This branch is out-of-date" (Nhánh này đã lỗi thời)
và có nút "Update branch", chúc mừng! Bạn đang chậm hơn nhưng có thể cập nhật
mà không có xung đột. Nhấn "Update branch" rồi tạo PR như hướng dẫn ở phần tiếp
theo. (Cũng có thể có nút "Discard", nhưng đừng nhấn trừ khi bạn muốn hủy thay
đổi của mình!)

Nếu thấy "This branch has conflicts that must be resolved" (Nhánh này có xung
đột cần giải quyết), tin xấu rồi. Bạn có một số thay đổi trong repo mâu thuẫn
với thay đổi của người khác trên upstream. Bạn có một số lựa chọn:

* UI cho biết bạn có thể mở pull request, điều đó sẽ cho bạn cơ hội giải quyết
  xung đột ngay trên trình duyệt như hướng dẫn ở phần tiếp theo.
* Nó cũng cho biết bạn có thể vứt bỏ thay đổi của mình và thay thế bằng upstream.
  Tiếc thật.
* Ngoài ra, bạn thực sự có thể merge nhánh từ upstream trên command line (dòng
  lệnh) và xử lý xung đột ở đó mà không cần mở PR trước. Xem [Đồng Bộ trên
  Command Line](#sync-cl), phía dưới.

Nói chung, nên giữ đồng bộ với repo upstream là điều tốt. Cách này giúp bạn đảm
bảo thay đổi của mình không xung đột với bất kỳ thay đổi nào trên upstream khi
bạn làm việc. Tốt hơn nhiều so với việc chờ đến cuối khi sẵn sàng tạo PR mới
giải quyết tất cả.

[i[Fork-->Syncing with Upstream]>]

## Tạo Pull Request

[i[Pull request-->Creating]<]

Giờ chúng ta đã chỉnh sửa fork của mình xong xuôi, chúng ta có thể hỏi người
bảo trì upstream xem họ có sẵn sàng chấp nhận nó vào repo chính thức không.

> **Có thể họ chưa sẵn sàng!** Đừng buồn nếu họ không trả lời hoặc trả lời
> bằng cách yêu cầu cải tiến patch của bạn. Hãy làm việc với chủ sở hữu để
> hoàn thành công việc đến sự hài lòng của cả hai.

Bắt đầu thôi!

* Nhấn vào nút "Contribute" rồi "Open pull request".
* Tìm dòng chữ "This branch has conflicts that must be resolved". Nếu tìm thấy,
  điều đó có nghĩa là upstream không thể tự động áp dụng PR của bạn và họ sẽ
  phải làm thủ công. Họ có nhiều khả năng từ chối hơn. Để tránh điều này, bạn
  có một số lựa chọn:
  * Đừng mở PR, quay lại và đồng bộ với upstream, sửa xung đột, rồi thử lại.
  * Hoặc nhấn nút "Resolve conflicts" ngay trên UI và dùng trình soạn thảo
    trên trình duyệt để giải quyết thủ công.
* Thêm tiêu đề đẹp.
* Thêm mô tả đầy đủ. Bạn đang yêu cầu ai đó tích hợp code của bạn vào dự án
  của họ, vì vậy hãy mô tả code đó làm gì để giúp cuộc sống của họ dễ dàng hơn
  khi xem xét. (Vì ví dụ này đi vào repo của tôi, bạn cứ giả vờ đã viết gì đó
  hay hay---tôi sẽ chỉ đóng PR thôi.)
* Nhấn "Create pull request"!

Thao tác này đưa chúng ta đến trang PR. Bạn có thể thêm bình luận hoặc đóng
yêu cầu (nếu bạn đổi ý).

Chủ upstream sẽ thấy PR đã được tạo, và giờ bạn phải chờ phản hồi.

Có thể họ trả lời với bình luận yêu cầu cải tiến hoặc đặt câu hỏi. Có thể họ
từ chối PR và đóng nó lại mà không merge. Hoặc có thể họ chấp nhận! Tuyệt vời!

[i[Pull request-->Creating]>]

## Mặt Kia: Merge Pull Request

[i[Pull request-->Merging]<]

Là chủ upstream, nếu có người tạo PR bạn sẽ được thông báo (trừ khi bạn đã tắt
thông báo đó) qua email và trong phần thông báo của GitHub ở góc trên bên phải.

Khi đó, bạn có thể vào trang dự án trên GitHub và quyết định làm gì với PR.

Ở đầu trang dự án, bạn sẽ thấy nút "Pull requests" với một số bên cạnh cho biết
có bao nhiêu PR đang chờ xử lý.

* Nhấn vào nút để xem danh sách.
* Nhấn vào tiêu đề PR để đến trang PR đó.

Giờ chúng ta đang xem PR. Đọc mô tả để biết nó làm gì, rồi **rất quan trọng**
là xem xét code!

> **Bạn sắp chấp nhận code từ người bạn có thể không quen biết.** Trên hành
> tinh này, hầu hết mọi người đều thân thiện, nhưng điều đó không có nghĩa là
> không có những kẻ xấu (thuật ngữ ngành gọi là *a\-\-holes*) đang tìm cách lợi
> dụng bạn bằng cách đưa vào code độc hại. Dù bạn đã biết người đóng góp này
> một năm, họ có thể đang chơi chiến lược dài hơi---và nếu điều đó có vẻ khó
> xảy ra với bạn,
> [flw[hãy đọc về vụ hack XZ utils xảy ra vào năm 2024|XZ_Utils_backdoor]].

Để xem xét code, hãy nhìn ngay bên dưới mô tả vào avatar của người đóng góp và
commit message. Nhấn vào commit message và bạn sẽ thấy diff, như mô tả trong
chương [_So Sánh File với Diff_](#diff). Những dòng có dấu `+` là được thêm, và
dòng có dấu `-` là bị xóa.

Nếu bạn chỉ muốn xem file như nó đã được người đóng góp chỉnh sửa, nhấn "..."
ở bên phải rồi "View file".

Nếu gần đúng nhưng bạn cần sửa thêm, bạn cũng có thể nhấn "Edit file" và thêm
commit trực tiếp vào PR.

Nếu mọi thứ trông ổn, cuộn xuống và hy vọng bạn sẽ thấy dòng "This branch has
no conflicts with the base branch" và "Merging can be performed automatically".
Đây là tin tốt.

Nếu vậy, bạn có thể nhấn "Merge pull request", và thao tác đó sẽ thêm những
thay đổi vào repo của bạn và đóng PR. Cũng nên thêm bình luận cảm ơn người đóng
góp---họ vừa làm việc cho bạn miễn phí đấy!

> **Đóng PR không xóa PR.** Bạn vẫn có thể mở lại nó.

Nhưng giả sử PR có xung đột và không thể tự động merge. GitHub phàn nàn rằng
"This branch has conflicts that must be resolved" và đưa ra một số lựa chọn.

Là chủ upstream, bạn có thể nhấn nút "Resolve conflicts" và sửa vấn đề nếu có
thể.

Hoặc bạn có thể từ chối PR và yêu cầu người mở nó giải quyết xung đột để cuộc
sống của bạn dễ dàng hơn với việc merge tự động.

[i[Pull request-->Merging]>]

## Tạo Nhiều Pull Request với Nhánh

[i[Pull request-->With branches]<]

Đây là điều về pull request: khi bạn tạo một PR, nó lấy tất cả những thay đổi
bạn có trên nhánh và gói chúng lại thành một. Không quan trọng các thay đổi đó
đang làm những việc hoàn toàn khác nhau; tất cả đều được đưa vào cùng một PR.

Điều này đôi khi không hay lắm từ góc độ quản lý. Có thể tôi muốn một PR cho
issue #1 và một PR khác cho issue #2!

Cách để làm điều đó là tạo nhánh local trên bản clone fork của bạn cho từng PR
riêng lẻ, rồi push những nhánh đó lên fork của bạn. Sau đó khi tạo PR, bạn
chọn nhánh muốn dùng. Dù nhánh của bạn có tên kiểu `feature1`, bạn vẫn có thể
merge nó vào nhánh `main` trên upstream.

Vậy hãy tạo nhánh mới cho tính năng:

``` {.default}
$ git switch -c feature1
  Switched to a new branch 'feature1'
```

Sau đó thực hiện thay đổi, add, và commit.

``` {.default}
$ vim readme.txt
$ git add readme.txt
$ git commit -m "feature 1"
  [feature1 1ad9e92] feature 1
   1 file changed, 1 insertion(+)
```

Rồi push chúng lên repo của bạn, thiết lập remote-tracking branch (nhánh theo
dõi từ xa):

``` {.default}
$ git push -u origin feature1
  Enumerating objects: 5, done.
  Counting objects: 100% (5/5), done.
  Delta compression using up to 8 threads
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 979 bytes | 979.00 KiB/s, done.
  Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
  remote: Resolving deltas: 100% (1/1), completed with 1 local
  remote: object.
  remote:
  remote: Create a pull request for 'feature1' on GitHub by
  remote: visiting:
  remote:      https://github.com/user/fork/pull/new/feature1
  remote:
  To github.com:user/fork.git
   * [new branch]      feature1 -> feature1
  branch 'feature1' set up to track 'origin/feature1'.
```

Giờ bạn có thể quay lại GitHub và tạo PR. (Và hãy xem phản hồi từ remote hữu
ích gợi ý cho bạn URL GitHub để truy cập nhằm tạo PR!)

Trong giao diện GitHub, có thể có một popup tiện lợi hiện ra như "feature1 had
recent pushes 4 minutes ago" và nút "Compare and pull request" để bạn nhấn tạo
PR.

Nhưng nếu đã quá lâu và popup biến mất thì không sao. Xem nút chọn nhánh ở góc
trên bên trái hiện đang ghi là "main" không? Kéo xuống và chọn nhánh "feature1"
mà bạn muốn tạo PR. Sau đó nhấn "Contribute" và mở PR.

Có một dòng ở đầu PR cho biết repo và nhánh mà sẽ được merge vào, và ở bên
phải, repo và tên nhánh của bạn mà bạn sẽ merge từ đó.

Phần còn lại của PR tiến hành như bình thường.

**Đừng xóa nhánh cho đến sau khi merge!** Khi đã được merge an toàn, GitHub sẽ
hiển thị nút "Delete branch" trên trang PR. Thao tác này sẽ xóa nhánh trên
GitHub, nhưng bạn vẫn phải xóa `feature1` và `origin/feature1` trên command
line.

[i[Pull request-->With branches]>]

## Xóa Pull Request

[i[Pull request-->Deleting]<]

Câu trả lời ngắn: không thể.

Câu trả lời dài: có thể.

Trớ trêu là câu trả lời ngắn lại dài hơn. Tôi không đặt ra luật lệ này đâu.

Câu trả lời dài chính xác: có thể nếu bạn là chủ upstream và PR có chứa thông
tin nhạy cảm.

Không có cách nào trên UI để xóa PR, dù bạn là người fork hay chủ repo được
fork. Và điều này có thể gây khó chịu đặc biệt khi bạn vô tình đưa vào thông
tin nhạy cảm như [flw[số an sinh xã hội
078-05-1120|Social_Security_number#SSNs_used_in_advertising]].

Nhưng vẫn còn hy vọng! Chủ upstream có thể truy cập trợ lý ảo của GitHub và
[fl[yêu cầu xóa pull
request|https://support.github.com/request?q=pull+request+removals]] và hình như
cũng được. Tôi chưa thử.

Nếu người tạo fork có cách xóa PR họ đã tạo, tôi chưa thấy. Bạn sẽ phải thuyết
phục chủ upstream để họ làm điều đó.

Trong mọi trường hợp, bạn chắc chắn phải thay đổi thông tin xác thực bị lộ ngay
lập tức và lấy đó làm bài học.

[i[Pull request-->Deleting]>]

## Đồng Bộ trên Command Line {#sync-cl}

[i[Fork-->Syncing with Upstream]<]

GitHub có nút Sync tiện lợi để đưa các thay đổi upstream vào fork của bạn, và
đây là bổ sung đáng hoan nghênh. Trước đây bạn phải làm theo cách khó.

Nhưng cách khó có thêm một lợi ích: nếu upstream xung đột với thay đổi của bạn,
bạn có thể merge chúng local trước khi tạo PR. Giao diện GitHub yêu cầu bạn tạo
PR để giải quyết xung đột.

Ngoài ra, nếu bạn thích command line và muốn nhanh chóng đồng bộ upstream vào
nhánh của mình, cách này cũng được.

Kế hoạch như sau:

1. Thêm remote `upstream` trỏ đến repo upstream.
2. Fetch (tải về) dữ liệu từ `upstream`.
3. Merge nhánh upstream vào nhánh của bạn.
4. Giải quyết xung đột.
5. Push nhánh của bạn.
6. Tạo PR giờ hy vọng không còn xung đột.

Hãy thử. Tôi sẽ ở nhánh `main` của mình và cố đồng bộ nó với nhánh `main` của
upstream. Tôi sẽ cho bạn thấy trông như thế nào khi có xung đột. (Nếu không có
xung đột, merge sẽ thành công tự động.)

Trước tiên: nếu bạn chưa làm, hãy thiết lập remote `upstream` trỏ đến repo của
chủ gốc. Đây là repo mà bạn đã fork từ đó. Vì bạn sẽ không push lên đó, bạn có
thể dùng phương thức SSH hoặc HTTP để truy cập. (Và remote này có thể đặt tên
bất kỳ, nhưng `upstream` là quy ước phổ biến.)

``` {.default}
$ git remote add upstream https://github.com/other/orig-repo.git
```

Và sau đó chúng ta cần lấy các commit mới từ repo upstream và merge chúng vào
của mình.

[i[Fetch]]

``` {.default}
$ git fetch upstream
  remote: Enumerating objects: 5, done.
  remote: Counting objects: 100% (5/5), done.
  remote: Compressing objects: 100% (1/1), done.
  remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0
  Unpacking objects: 100% (3/3), 950 bytes | 950.00 KiB/s, done.
  From https://github.com/other/upstream
   * [new branch]      main       -> upstream/main

$ git switch main   # Make sure we're on the main branch

$ git merge upstream/main
  Auto-merging readme.txt
  CONFLICT (content): Merge conflict in readme.txt
  Automatic merge failed; fix conflicts and then commit the result.
```

(Bạn cũng có thể rebase nếu muốn.)

Lúc này, chúng ta nên chỉnh sửa file và giải quyết xung đột, rồi hoàn thành
như thường.

Và sau đó chúng ta push lại lên fork trên GitHub!

``` {.default}
$ git push
  Enumerating objects: 7, done.
  Counting objects: 100% (7/7), done.
  Delta compression using up to 8 threads
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 999 bytes | 999.00 KiB/s, done.
  Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
  remote: Resolving deltas: 100% (1/1), completed with 1 local
  remote: object.
  To github.com:user/fork.git
   8b2476c..c8a7e0a  main -> main
```

Nếu chúng ta quay lại giao diện GitHub lúc này và mở PR, nó sẽ nói "These
branches can be automatically merged" (Các nhánh này có thể tự động merge) ---
đó là điều ai cũng muốn nghe.

Khi đã thiết lập remote `upstream`, tất cả những gì bạn cần làm để đồng bộ trong
tương lai là chạy [i[Fetch]] `git fetch upstream` rồi merge hoặc rebase với nó.

[i[Fork-->Syncing with Upstream]>]

[i[Pull requests]>]
[i[Fork]>]
