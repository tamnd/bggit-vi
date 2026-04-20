# GitHub: Cách Sử Dụng

[i[GitHub]<]

Chúng ta đã nói rằng GitHub (đó là một web frontend (giao diện web) độc
quyền cho Git do Microsoft điều hành và sở hữu) không phải là Git, và
điều đó đúng. Cũng đúng là bạn không cần phải chạm đến GitHub để dùng
Git.

Tuy nhiên, *thực sự* phổ biến là mọi người dùng GitHub, vì vậy chúng
ta sẽ thiết lập nó trong chương này.

Ở đây chúng ta sẽ tạo tài khoản GitHub mới và xem cách authentication
(xác thực) hoạt động. Điều này bao gồm một số thiết lập một lần.

Nếu bạn đã có tài khoản GitHub, bạn có thể bỏ qua phần đó.

Nếu bạn đã thiết lập xác thực với GitHub CLI hoặc với SSH keys, bạn
cũng có thể bỏ qua phần đó.

Nếu bạn không cần dùng GitHub, bạn có thể bỏ qua toàn bộ chương này!

## Tạo Tài Khoản GitHub

[i[GitHub-->Account creation]]

Hãy đến [fl[GitHub|https://github.com/]] và nhấp `Sign Up`. Làm theo
những hướng dẫn đó.

Cuối cùng bạn sẽ đến trang dashboard (bảng điều khiển) chính của mình.

## Tạo Repo Mới trên GitHub

[i[GitHub-->Repo creation]]

Điều này sẽ tạo một repository trên GitHub mà bạn sở hữu. Nó không tạo
repository local --- bạn sẽ phải clone repo cho điều đó, điều chúng ta
sẽ làm sau.

Trong GitHub, có nút `New` màu xanh lá ở bên trái của dashboard.

Ngoài ra, có một pulldown `+` ở góc phải trên cùng có tùy chọn "New
Repository". Nhấp vào một trong số đó.

Trên trang tiếp theo:

1. Nhập "Repository name" (Tên repository), có thể là bất cứ thứ gì
   miễn là bạn chưa có repo với tên đó. Hãy dùng `test-repo` cho ví
   dụ này.

2. Đánh dấu vào ô "Add a README file".

   (Trong tương lai, bạn có thể đã có một repo local mà bạn sẽ push
   lên repo mới này. Nếu vậy, **đừng** đánh dấu ô này vì nó sẽ ngăn
   việc push xảy ra.)

3. Nhấp `Create repository` ở cuối trang.

Và đó là xong.

## Xác Thực

[i[GitHub-->Authentication]]

Trước khi đến phần clone, hãy nói về authentication. Trong phần trước
của phần giới thiệu, chúng ta thấy rằng đăng nhập bằng username/password
đã bị vô hiệu hóa, vì vậy chúng ta phải làm điều gì đó khác.

Có một vài tùy chọn:

* Dùng công cụ gọi là GitHub CLI
* Dùng SSH keys (khóa SSH)
* Dùng Personal Authentication Tokens (Token xác thực cá nhân)

GitHub CLI có lẽ dễ hơn. SSH keys thì "geektacular" (cực kỳ geek).
Mình chỉ gần đây mới biết bạn có thể xác thực với personal access
tokens, vì vậy mình không thể nói nhiều về chúng.

Cá nhân, mình dùng SSH keys. Nhưng những người khác... thì không. Tùy
bạn.

Nếu bạn đã thiết lập xác thực hoạt động với GitHub, hãy bỏ qua các
phần này.

Nếu không, hãy chọn một trong số chúng (như SSH) và dùng nó.

### GitHub CLI

[i[GitHub-->GitHub CLI setup]]

Đây là command line interface (giao diện dòng lệnh) cho GitHub. Nó làm
nhiều thứ, nhưng một trong số đó là cung cấp authentication helper (trợ
giúp xác thực) để bạn có thể thực hiện những việc như thực sự push lên
remote repo.

[fl[Truy cập trang GitHub CLI|https://cli.github.com/]] và làm theo
hướng dẫn cài đặt. Nếu bạn đang dùng WSL, Linux, hoặc một Unix variant
khác, hãy xem [fl[hướng dẫn cài đặt|https://github.com/cli/cli#installation]]
của họ cho các nền tảng khác.

Sau khi cài đặt, bạn sẽ có thể chạy `gh --version` và thấy một số
thông tin phiên bản, ví dụ:

``` {.default}
$ gh --version
  gh version 2.42.1 (2024-01-15)
  https://github.com/cli/cli/releases/tag/v2.42.1
```

Sau đó bạn sẽ muốn chạy hai lệnh sau:

``` {.default}
$ gh auth login
$ gh auth setup-git
```

Lệnh đầu tiên (`login`) sẽ dẫn bạn qua quá trình đăng nhập. Bạn sẽ
phải làm lại điều này nếu bạn đăng xuất.

Nó sẽ hỏi bạn có muốn dùng SSH hay HTTP. Nếu bạn đã thiết lập SSH keys,
mình khuyến nghị dùng cái đó. Nếu bạn chưa có, chọn "HTTP" khi được
hỏi. Sự khác biệt chính là với HTTP, thông tin đăng nhập được lưu không
được mã hóa, trong khi với SSH, bạn có thể bảo vệ chúng bằng passphrase.
Xem bên dưới để thiết lập SSH keys.

Và đăng nhập bằng web browser là dễ nhất, khi được hỏi.

Lệnh thứ hai (`setup-git`) chỉ dùng một lần. Lệnh này chỉ thêm vào
global config (cấu hình toàn cục) của bạn một số thứ để giúp xác thực.

### SSH Keys

[i[GitHub-->SSH setup]]

Nếu bạn không muốn cài đặt và dùng GitHub CLI, bạn có thể thay thế bằng
cách tiếp cận này. Đây là cách phức tạp hơn, nhưng có nhiều geek cred
(uy tín geek) hơn. Đây là cách mình dùng.

Nếu bạn đã có một SSH keypair (cặp khóa SSH), bạn có thể bỏ qua bước
tạo khóa. Bạn biết mình có một cái nếu bạn chạy `ls ~/.ssh` và thấy
một file như `id_rsa.pub` hoặc `id_ed25519.pub`.

Để tạo một keypair mới, chạy lệnh sau:

``` {.default}
$ ssh-keygen -t ed25519 -C youremail@example.com
```

(Flag `-C` đặt "comment" (bình luận) trong khóa. Có thể là bất cứ thứ
gì, nhưng địa chỉ email là phổ biến.)

Điều này tạo ra rất nhiều prompt, nhưng bạn có thể chỉ nhấn ENTER cho
tất cả chúng.

> **Thực hành tốt nhất là dùng mật khẩu để truy cập khóa này**, nếu
> không bất kỳ ai có quyền truy cập vào private key có thể mạo danh bạn
> và truy cập tài khoản GitHub của bạn, và bất kỳ tài khoản nào khác
> bạn đã thiết lập để dùng khóa đó. Nhưng gõ mật khẩu mỗi lần bạn muốn
> dùng khóa (là mỗi khi bạn làm bất cứ điều gì với GitHub từ command
> line) thật phiền, vì vậy mọi người dùng _key agent_ (đại lý khóa) ghi
> nhớ mật khẩu trong một thời gian.
>
> Nếu bạn không có mật khẩu trên khóa của mình, bạn đang dựa vào thực
> tế là không ai có thể lấy một bản sao của phần private key được lưu
> trên máy tính của bạn. Nếu bạn tin rằng máy tính của mình an toàn,
> thì bạn không cần mật khẩu trên khóa. Bạn có tự tin không?
>
> Thiết lập key agent nằm ngoài phạm vi của tài liệu này, và tác giả
> không chắc nó hoạt động như thế nào trong WSL. [fl[GitHub có tài liệu
> về vấn đề này|https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent]].
>
> Cho demo này, chúng ta sẽ để trống mật khẩu. Tất cả điều này có thể
> được làm lại với khóa mới có mật khẩu nếu bạn chọn làm vậy sau.

Dù sao, chỉ nhấn ENTER cho tất cả các prompt cho bạn thứ gì đó như
thế này:

``` {.default}
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/user/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_ed25519
Your public key has been saved in id_ed25519.pub
The key fingerprint is:
SHA256:/lrT43BQBRPJpUXxpTBFInhdtZSQjQwxU4USwt5c0Lw user@locahost
The key's randomart image is:
+--[ED25519 256]--+
|        .o.X^%^=+|
|        ..oo*^.=o|
|        ..o = o..|
|         . + E   |
|        S .      |
|       .   o     |
|        . + +    |
|         o = .   |
|        ... .    |
+----[SHA256]-----+
```

> **Nếu bạn chọn tên file khác với tên mặc định cho khóa của mình**,
> bạn sẽ phải thực hiện một số [fl[cấu hình bổ sung để làm cho nó hoạt
> động với
> GitHub|https://www.baeldung.com/linux/ssh-private-key-git-command]].

> **Cái randomart với tất cả những ký tự kỳ lạ là gì vậy?** Đó là một
> biểu diễn trực quan của khóa đó. Có cách cấu hình SSH để bạn thấy
> randomart mỗi lần đăng nhập. Và ý tưởng là nếu một ngày nào đó bạn
> thấy nó trông khác, có thể có điều gì đó không ổn về mặt bảo mật.
> Mình nghi ngờ hầu hết mọi người không bao giờ nhìn vào nó nữa sau khi
> nó được tạo ra.

Bây giờ nếu bạn gõ `ls ~/.ssh` bạn sẽ thấy thứ gì đó như thế này:

``` {.default}
id_ed25519    id_ed25519.pub
```

File đầu tiên là _private key_ (khóa riêng tư) của bạn. Không bao giờ
chia sẻ với bất kỳ ai. Bạn không có lý do để sao chép nó.

File thứ hai là _public key_ (khóa công khai) của bạn. Có thể chia sẻ
tự do với bất kỳ ai, và chúng ta sẽ chia sẻ nó với GitHub trong một
giây để bạn có thể đăng nhập với nó.

> **Nếu bạn gặp sự cố trong các phần con sau**, hãy thử chạy hai lệnh
> này:
>
> ``` {.default}
> $ chmod 700 ~/.ssh
> $ chmod 600 ~/.ssh/*
> ```
> <!-- ` -->
>
> Bạn chỉ cần làm điều đó một lần, nhưng SSH có thể khó tính nếu
> permissions (quyền) trên các file đó không bị khóa.

Bây giờ để làm cho điều này hoạt động, bạn phải cho GitHub biết public
key của bạn là gì.

Trước tiên, lấy một bản sao public key của bạn vào clipboard. ***Hãy
chắc chắn bạn đang lấy file có extension `.pub`!***

``` {.default}
$ cat ~/.ssh/id_ed25519.pub
```

Bạn sẽ thấy thứ gì đó như thế này:

``` {.default}
ssh-ed25519 AAAC3N[a bunch of letters]V+znpoO youremail@example.com
```

Sao chép toàn bộ vào clipboard để bạn có thể paste sau.

Bây giờ hãy vào GitHub, và nhấp vào biểu tượng avatar ở góc trên bên
phải.

Chọn "Settings".

Sau đó ở bên trái, chọn "SSH and GPG keys".

Nhấp "New SSH Key".

Cho tiêu đề, nhập thứ gì đó có thể nhận dạng được, như "My laptop key".

Loại khóa là "Authentication Key".

Sau đó paste khóa của bạn vào trường "Key".

Và nhấp "Add SSH key".

Chúng ta sẽ dùng SSH để clone các URL sau. Hãy nhớ điều đó.

### Dùng Personal Access Tokens

Nhớ lại chương trước khi chúng ta cố clone một URL repo HTTPS trên
command line và nó nhắc nhập username và password không hoạt động không?

Vâng, chúng ta thực sự có thể tạo mật khẩu mới *sẽ* hoạt động trong
trường hợp đó. Chúng được gọi là *personal access tokens* (token truy
cập cá nhân).

[fl[GitHub có nhiều tài liệu về điều
này|https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens]]
nhưng ý chính là bạn sẽ tạo một _token_ đại diện cho một loại truy cập
nào đó, ví dụ "khả năng đọc và ghi repo của tôi", và bạn sẽ dùng nó
thay cho mật khẩu trên command line.

Vì vậy ví dụ thất bại cuối cùng đó sẽ trông như thế này:

``` {.default}
Username for 'https://github.com': [MY USERNAME]
Password for 'https://beejjorgensen@github.com': [MY TOKEN]
```

Nói cách khác:

1. Tạo một token.
2. Dùng token đó làm mật khẩu.

Máy tính của bạn có thể tự động lưu những thông tin đăng nhập đó để bạn
không phải nhập chúng mỗi lần. Hoặc có thể không.

Một trong những điều chính mà personal access tokens có thể cung cấp
cho bạn là kiểm soát truy cập chi tiết. Bạn có thể giới hạn truy cập
chỉ đọc, hoặc chỉ cho một số repo nhất định, v.v.

Ngoài ra, bạn cũng có thể dùng GitHub CLI authentication với token. Bạn
chỉ cần đưa nó vào standard input. Giả sử bạn có token trong file gọi
là `mytoken.txt`. Bạn có thể xác thực với GitHub CLI như sau:

``` {.default}
$ gh auth login --with-token < mytoken.txt
```

Giống như với SSH keys, nếu bạn mất laptop dùng một access token cụ
thể, bạn có thể đơn giản vô hiệu hóa token đó thông qua UI của GitHub
để những kẻ xấu không thể dùng nó.

## Tạo Clone Local của Repo

[i[GitHub-->Cloning]]

Chúng ta cần tìm ra URL của repo để có thể clone nó.

Nếu bạn nhấp vào biểu tượng của bạn ở góc trên bên phải, sau đó "My
Repositories", bạn sẽ thấy một trang với tất cả repo của bạn. Lúc này,
nó có thể chỉ là repo `test-repo` của bạn. Nhấp vào tên.

Và bạn sẽ ở trên trang repo. Bạn có thể duyệt các file ở đây, trong số
những thứ khác, nhưng thực sự chúng ta muốn lấy clone URL.

Nhấp nút "Code" màu xanh lớn.

Những gì bạn làm tiếp theo phụ thuộc vào việc bạn đang dùng GitHub CLI
hay SSH keys.

### Clone từ GitHub với GitHub CLI

[i[GitHub-->Cloning with GitHub CLI]]

Bạn có hai tùy chọn.

* **Tùy chọn 1**: Trước đó khi chúng ta xác thực với `gh auth login`
  mình đã nói hãy nhớ xem bạn đã chọn HTTPS hay SSH. Tùy thuộc vào cái
  bạn đã chọn, bạn nên chọn tab đó trên cửa sổ này.

  Sao chép URL.

  Vào command line và chạy `git clone [URL]` trong đó `[URL]` là những
  gì bạn đã sao chép. Vì vậy nó sẽ như thế này cho HTTPS:

  ``` {.default}
  $ git clone https://github.com/user/test-repo.git
  ```

  hoặc như thế này cho SSH:

  ``` {.default}
  $ git clone git@github.com:user/test-repo.git
  ```

* **Tùy chọn 2**: Chọn tab "GitHub CLI". Chạy lệnh họ có, sẽ là thứ
  gì đó như:

  ``` {.default}
  $ gh repo clone user/test-repo
  ```

### Clone từ GitHub với SSH Keys

[i[GitHub-->Cloning with SSH]]

Nếu bạn đã thiết lập SSH key trước đó, bạn có thể dùng phương pháp này.

Sau khi nhấn nút "Code" màu xanh, hãy đảm bảo tab "SSH" được chọn.

Sao chép URL đó.

Vào command line và chạy `git clone [URL]` trong đó `[URL]` là những gì
bạn đã sao chép. Vì vậy nó sẽ là thứ gì đó như thế này:

``` {.default}
$ git clone git@github.com:user/test-repo.git
```

## Thực Hiện Thay Đổi và Push!

[i[Push]]

Bây giờ bạn đã clone repo, bạn sẽ có thể `cd` vào thư mục đó, chỉnh
sửa file, `git add` nó lên stage, rồi `git commit -m message` để tạo
commit...

Và sau đó `git push` để push nó trở lại clone trên GitHub!

Và sau đó nếu bạn vào trang repo trên GitHub và nhấn reload, bạn sẽ
thấy các thay đổi của mình ở đó!

Và bây giờ chúng ta trở lại với luồng phổ biến chuẩn đó:

1. _Clone_ một _remote_ repo.
2. Thực hiện một số thay đổi local.
3. Thêm những thay đổi đó vào _stage_.
4. _Commit_ những thay đổi đó.
5. _Push_ những thay đổi của bạn trở lại remote repo.
6. Quay lại Bước 2.

## Cộng Tác trên GitHub

Có hai kỹ thuật chính cho điều này:

1. Fork/pull request
2. Thêm collaborator (cộng tác viên)

Chúng ta sẽ nói về cái đầu tiên trong tương lai.

[i[GitHub-->Adding collaborators]]
Bây giờ, cách dễ nhất để thêm collaborators là chỉ cần thêm họ vào
repo của bạn.

Trên trang repo trên GitHub, chọn "Settings", sau đó "Collaborators"
ở bên trái.

Sau khi xác thực, bạn có thể nhấp "Add people". Nhập username của người
bạn muốn cộng tác.

Họ sẽ phải chấp nhận lời mời từ GitHub inbox của họ, nhưng sau đó họ
sẽ có quyền truy cập repo.

Hãy chắc chắn chỉ làm điều này với những người bạn tin tưởng!

[i[GitHub]>]
