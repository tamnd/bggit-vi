# Dùng Subdirectories với Git

[i[Subdirectories]<]

Đây là một chương ngắn hơn, nhưng chúng ta muốn nói về hành vi của Git
khi làm việc trong các subdirectory (thư mục con) và một số gotcha (cạm
bẫy) mà bạn có lẽ không muốn vướng vào.

## Repos và Subdirectories

Khi bạn chạy lệnh `git`, Git tìm kiếm một [i[`.git` directory]]
thư mục đặc biệt gọi là `.git` ("dot git") trong thư mục hiện tại. Như
chúng ta đã đề cập trước, đây là thư mục, được tạo khi bạn tạo repo,
lưu giữ metadata về repo.

Nhưng nếu bạn đang ở trong một subdirectory trong dự án của mình và
không có thư mục `.git` ở đó thì sao?

Git bắt đầu bằng cách tìm kiếm trong thư mục hiện tại cho `.git`. Nếu
không tìm thấy ở đó, nó tìm trong thư mục parent (cha). Và nếu không
ở đó, nó tìm trong grandparent (ông nội), v.v., tất cả đường về root
directory (thư mục gốc).

### Còn về Subprojects thì sao?

[i[Subprojects]]

Một câu hỏi phổ biến của sinh viên là, "Tôi có nên tạo một repo duy
nhất cho CS101 với các subdirectory cho mỗi dự án không? Hay tôi nên
tạo một repo khác nhau cho mỗi dự án?"

Trước tiên, hãy xem instructor (giảng viên) của bạn có yêu cầu hoặc
ưu tiên không, nhưng ngoài ra, về mặt kỹ thuật không quan trọng cách
tiếp cận nào bạn dùng.

Trong thực tế, các repo lớn hơn (lớn hơn nhiều so với những gì bạn
thường dùng cho một lớp học) mất nhiều thời gian hơn để clone do kích
thước của chúng.

Điều gì xảy ra nếu bạn khởi tạo một Git repo mới _bên trong_ một repo
hiện có? Không hay. Đừng làm vậy.

Để kết hợp các repo khác nhau trong cùng một hierarchy (cấu trúc phân
cấp), Git có khái niệm submodule (module con), và bạn có thể tìm thêm
thông tin trong [chương Submodules](#submodules). Nếu bạn đang học, các
submodule thường không được dùng.

## Vô Tình Tạo Repo trong Home Directory

Git sẽ không ngăn bạn tạo repo trong home directory (thư mục home) của
bạn, tức là một repo chứa mọi thứ trong tất cả các thư mục của bạn.

Nhưng đó có lẽ không phải là điều bạn muốn làm.

Làm thế nào ai đó mắc lỗi này? Thường là với `git init .` trong home
directory của bạn. Bạn cũng có thể mắc lỗi này bằng cách khởi động VS
Code từ home directory của bạn và nói với nó "Initialize Repository"
tại vị trí đó.

Điều này đặc biệt nguy hiểm vì nếu bạn đang ở trong một subdirectory
mà bạn _nghĩ_ là một repo độc lập, bạn có thể đã bị nhầm vì Git tìm
kiếm thư mục parent cho thư mục `.git` và nó có thể đang tìm thấy cái
giả mà bạn vô tình tạo trong home directory.

Chúng tôi[^5d3e] khuyến nghị chống lại một repo lớn từ home directory
của bạn. Bạn nên có các subdirectory riêng biệt cho mỗi repo của mình.

[^5d3e]: Tức là tất cả những người yêu thích Git nói chung.

[i[`.git` directory-->Removing]]
Nếu bạn vô tình tạo một repo ở nơi bạn không muốn, thay đổi một Git
repo thành một subdirectory thông thường cũng đơn giản như xóa thư mục
`.git`. Hãy cẩn thận rằng bạn đang xóa đúng cái khi bạn làm điều này!

> [i[`.git` directory-->Preventing in home]]Một mẹo bạn có thể làm để
> ngăn Git tạo repo trong home directory của bạn là đặt trước một thư
> mục `.git` không thể ghi.
>
> ``` {.default}
> $ mkdir ~/.git       # Make the .git directory
> $ chmod 000 ~/.git   # Take away all permissions
> ```
> <!-- ` -->
>
> Bằng cách này khi Git cố tạo thư mục metadata của nó ở đó, nó sẽ bị
> dừng lại vì bạn không có quyền ghi vào thư mục `.git` đó.
>
> (Bạn luôn có thể xóa thư mục này với `rmdir` ngay cả khi bạn không
> có quyền ghi vào nó.)

## Các Subdirectory Trống trong Repos

[i[Subdirectories-->Empty]]
Hóa ra Git không hỗ trợ điều này. Nó chỉ theo dõi các file, vì vậy
nếu bạn muốn một subdirectory được đại diện trong repo của mình, bạn
phải có ít nhất một file trong đó.

Một điều phổ biến cần làm là thêm một file trống gọi là `.gitkeep` ("dot
git keep") vào subdirectory, sau đó thêm nó vào repo. Điều này sẽ khiến
Git tạo lại subdirectory khi nó clone hoặc merge thư mục `.gitkeep`.

> File `.gitkeep` không đặc biệt theo bất kỳ cách nào, ngoài quy ước.
> File có thể được gọi là bất cứ điều gì. Ví dụ, nếu bạn biết mình sẽ
> cần đặt một `.gitignore` trong thư mục đó, bạn có thể chỉ dùng cái
> đó thay thế. Hoặc một `README`.

[i[Subdirectories]>]
