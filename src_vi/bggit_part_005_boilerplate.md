# Lời Mở Đầu
<!-- Beej's guide to Git
# vim: ts=4:sw=4:nosi:et:tw=72
-->

<!-- No hyphenation -->
<!-- [nh[scalbn]] -->

<!-- Index see alsos -->
[is[Configuration-->Alias==>see Alias]]
[is[Branch-->on GitHub==>see GitHub, Branches]]
[is[Branch-->Diff==>see Diff, Between branches]]
[is[Detached `HEAD`==>see `HEAD`, Detached]]
[is[Fast-forward==>see Merge, Fast-forward]]
[is[Ignoring files==>see `.gitignore`]]
[is[Index==>see Stage]]
[is[`main`==>see Branch, `main`]]
[is[`master`==>see Branch, `master`]]
[is[`origin`==>see Remotes, `origin`]]
[is[`origin/main`==>see Branch, Remote tracking]]
[is[Recursion==>see Recursion]]
[is[Rename==>see Move]]
[is[Undelete==>see Remove, Undelete]]

[is[`git add`==>see Add]]
[is[`git add -p`==>see Patch mode]]
[is[`git blame`==>see Blame]]
[is[`git branch`==>see Branch]]
[is[`git checkout`==>see Checkout]]
[is[`git cherry-pick`==>see Cherry-pick]]
[is[`git clone`==>see Clone]]
[is[`git commit`==>see Commit]]
[is[`git config`==>see Configuration]]
[is[`git diff`==>see Diff]]
[is[`git fetch`==>see Fetch]]
[is[`git log`==>see Log]]
[is[`git merge`==>see Merge]]
[is[`git mv`==>see Move]]
[is[`git pull`==>see Pull]]
[is[`git push`==>see Push]]
[is[`git push --set-upstream`==>see Branch, Set upstream]]
[is[`git push -u`==>see Branch, Set upstream]]
[is[`git rebase`==>see Rebase]]
[is[`git reflog`==>see Reflog]]
[is[`git remote`==>see Remote]]
[is[`git reset`==>see Reset]]
[is[`git reset -p`==>see Patch mode]]
[is[`git restore`==>see Restore]]
[is[`git revert`==>see Revert]]
[is[`git rm`==>see Remove]]
[is[`git stash`==>see Stash]]
[is[`git status`==>see Status]]
[is[`git switch`==>see Switch]]
[is[`git tag`==>see Tag]]
[is[`git worktree`==>see Worktree]]

Chào mọi người, lại là mình đây! Với vai trò là một người trong ngành
chuyển sang làm giảng viên đại học, mình thường xuyên thấy sinh viên
vật lộn với Git.

Mà ai trách họ được chứ? Đây là một hệ thống trông có vẻ cực kỳ phức
tạp với đủ loại cạm bẫy: merge conflict (xung đột khi gộp), detached
head (đầu bị tách), remote (kho từ xa), cherrypick, rebase và vô số
lệnh khác mà chẳng ai biết chúng làm gì.

Và đó chính xác là lý do tồn tại của tài liệu này: hãy cùng nhau hiểu
cho rõ và đi từ người mới hoàn toàn đến trình độ trung cấp! Mình sẽ bắt
đầu từ những thứ dễ (theo kế hoạch) với các lệnh xen kẽ cùng một số lý
thuyết hoạt động. Và chúng ta sẽ thấy rằng hiểu Git làm gì bên dưới
mui xe là điều cốt lõi để dùng nó đúng cách.

Và mình *hứa* là sau khi đọc xong một phần của tài liệu này, bạn có thể
thực sự bắt đầu thích Git và thích dùng nó.

Mình đã dùng Git nhiều năm rồi (ngay lúc này mình đang dùng nó cho
source code của tài liệu này đây) và hoàn toàn có thể xác nhận rằng
nó sẽ ngày càng dễ hơn theo thời gian, rồi thậm chí trở thành phản xạ.

Nhưng trước tiên, mấy chuyện bắt buộc phải nói!

## Đối Tượng Độc Giả

Bản thảo đầu tiên của tài liệu này được đưa lên mạng cho sinh viên của
trường đại học nơi mình làm (hay có thể vẫn đang làm, tùy lúc bạn đọc
cái này) giảng viên. Vì vậy khá tự nhiên khi nghĩ đó là đối tượng mà
mình nhắm đến.

Nhưng mình cũng hy vọng có đủ nhiều người ngoài đó có thể nhận được gì
đó hữu ích từ tài liệu này, và mình đã viết nó theo nghĩa chung hơn với
tất cả các bạn không phải sinh viên đại học trong đầu.

Tài liệu này giả định bạn có kỹ năng cơ bản về POSIX shell (tức là
Bash, Zsh, v.v.), cụ thể:

* Bạn biết các lệnh cơ bản như `cd`, `ls`, `mkdir`, `cp`, v.v.
* Bạn có thể cài thêm phần mềm.

Nó cũng giả định bạn đang ở môi trường Unix-like (kiểu Unix), ví dụ
Linux, BSD, Unix, macOS, WSL, v.v. với POSIX shell. Bạn càng xa với môi
trường đó (ví dụ PowerShell, Commodore 64), bạn sẽ càng phải dịch thủ
công nhiều hơn.

Windows là điểm khó khăn tự nhiên ở đây. May mắn thay, Git for Windows
đi kèm với một biến thể Bash shell gọi là Git Bash. Bạn cũng có thể
cài
[fl[WSL|https://learn.microsoft.com/en-us/windows/wsl/]] để có môi
trường Linux chạy trên máy Windows của bạn. Mình hoàn toàn khuyến nghị
cách này cho những bạn thích hack, vì hệ thống Unix-like rất tuyệt cho
hacker, và thêm nữa mình khuyến nghị tất cả các bạn hãy trở thành hacker.

## Trang Chủ Chính Thức

Vị trí chính thức của tài liệu này (hiện tại) là
[fl[https://beej.us/guide/bggit/|https://beej.us/guide/bggit/]].

## Chính Sách Email

Mình thường sẵn sàng giúp đỡ qua email nên cứ thoải mái viết, nhưng
mình không đảm bảo sẽ trả lời. Cuộc sống của mình khá bận rộn và đôi
khi mình không có thời gian trả lời câu hỏi của bạn. Khi đó, mình
thường chỉ xóa tin nhắn. Không phải vì lý do cá nhân; chỉ là mình sẽ
không bao giờ có thời gian để đưa ra câu trả lời chi tiết mà bạn cần.

Theo nguyên tắc, câu hỏi càng phức tạp, khả năng mình trả lời càng
thấp. Nếu bạn có thể thu hẹp câu hỏi trước khi gửi và chắc chắn đưa
vào bất kỳ thông tin liên quan nào (như nền tảng, trình biên dịch, thông
báo lỗi bạn đang gặp, và bất cứ điều gì khác bạn nghĩ có thể giúp mình
xử lý sự cố), bạn sẽ có nhiều khả năng nhận được phản hồi hơn.

Nếu bạn không nhận được phản hồi, hãy tiếp tục tìm hiểu, cố tìm câu
trả lời, và nếu vẫn còn mơ hồ, hãy viết lại cho mình với thông tin bạn
đã tìm được và hy vọng nó đủ để mình có thể giúp.

Sau khi đã dặn dò bạn về cách viết và không viết cho mình như vậy, mình
chỉ muốn cho bạn biết rằng mình _hoàn toàn_ trân trọng tất cả những lời
khen ngợi mà tài liệu đã nhận được qua nhiều năm. Đó là nguồn động lực
thực sự, và mình rất vui khi biết nó đang được sử dụng cho mục đích
tốt! `:-)` Cảm ơn bạn!

## Nhân Bản Trang Web

Bạn hoàn toàn được hoan nghênh nhân bản trang web này, dù công khai hay
riêng tư. Nếu bạn nhân bản trang web công khai và muốn mình đặt liên
kết đến nó từ trang chính, hãy gửi email cho mình tại
[`beej@beej.us`](mailto:beej@beej.us).

## Ghi Chú cho Người Dịch

[i[Translations]<]
Nếu bạn muốn dịch tài liệu sang ngôn ngữ khác, hãy viết cho mình tại
[`beej@beej.us`](mailto:beej@beej.us) và mình sẽ đặt liên kết đến bản
dịch của bạn từ trang chính. Hãy thêm tên và thông tin liên hệ của bạn
vào bản dịch.

Hãy lưu ý các hạn chế giấy phép trong phần Bản Quyền và Phân Phối,
bên dưới.
[i[Translations]>]

## Bản Quyền và Phân Phối

Beej's Guide to Git là Copyright © 2024 Brian "Beej Jorgensen" Hall.

Với các ngoại lệ cụ thể cho source code (mã nguồn) và các bản dịch,
như bên dưới, tác phẩm này được cấp phép theo Creative Commons
Attribution-Noncommercial-No Derivative Works 3.0 License. Để xem bản
sao của giấy phép này, hãy truy cập
[`https://creativecommons.org/licenses/by-nc-nd/3.0/`](https://creativecommons.org/licenses/by-nc-nd/3.0/)
hoặc gửi thư đến Creative Commons, 171 Second Street, Suite 300, San
Francisco, California, 94105, USA.

Một ngoại lệ cụ thể cho phần "No Derivative Works" của giấy phép là
như sau: tài liệu này có thể được tự do dịch sang bất kỳ ngôn ngữ nào,
miễn là bản dịch chính xác và tài liệu được in lại đầy đủ. Các hạn chế
giấy phép tương tự áp dụng cho bản dịch như đối với tài liệu gốc. Bản
dịch cũng có thể bao gồm tên và thông tin liên hệ của người dịch.

Source code lập trình được trình bày trong tài liệu này được cấp cho
public domain (miền công cộng) và hoàn toàn không có hạn chế giấy phép.

Các nhà giáo dục được khuyến khích tự do giới thiệu hoặc cung cấp bản
sao của tài liệu này cho sinh viên của họ.

Liên hệ [`beej@beej.us`](mailto:beej@beej.us) để biết thêm thông tin.

## Lời Cảm Ơn

Những điều khó khăn nhất khi viết các tài liệu này là:

* Học tài liệu đủ chi tiết để có thể giải thích nó
* Tìm ra cách tốt nhất để giải thích nó rõ ràng, một quá trình lặp đi
  lặp lại có vẻ vô tận
* Đặt mình ra như một _chuyên gia_ được gọi như vậy, khi thực ra mình
  chỉ là một con người bình thường đang cố hiểu mọi thứ, giống như mọi
  người khác
* Kiên trì khi có quá nhiều thứ khác thu hút sự chú ý của mình

Nhiều người đã giúp mình trong suốt quá trình này, và mình muốn ghi
nhận những người đã làm cho cuốn sách này trở thành hiện thực:

* Tất cả mọi người trên Internet đã quyết định chia sẻ kiến thức của
  họ dưới hình thức này hay hình thức khác. Việc chia sẻ tự do thông
  tin hướng dẫn là điều làm cho Internet trở thành nơi tuyệt vời như
  vậy.
* Tất cả những người đã gửi các bản sửa lỗi và pull request về mọi
  thứ, từ hướng dẫn gây hiểu nhầm đến lỗi đánh máy.

Cảm ơn! ♥
