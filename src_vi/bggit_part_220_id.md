# Thay Đổi Identity (Danh Tính) {#changing-identity}

[i[Identity]<]

Có một vài cách bạn được nhận dạng khi làm việc với Git.

Chúng được lưu trong:

* biến cấu hình `user.name` và `user.email`
* SSH key bạn dùng để xác thực với remote server như GitHub
* GPG key bạn dùng để ký commit (hiếm gặp)

Mọi thứ đều ổn nếu bạn chỉ dùng một identity duy nhất, nhưng đôi khi bạn có thể muốn dùng các identity khác nhau. Ví dụ, có thể với những dự án vui vẻ cá nhân bạn dùng một identity và SSH key, nhưng rồi bạn nhận một hợp đồng và muốn dùng email chuyên nghiệp, đồng thời phải kết nối đến một server khác với SSH key khác.

Hãy cùng xem các mặc định cho tất cả những thứ này, cũng như cách thay đổi chúng theo từng repo.

## Thay Đổi Biến Cấu Hình User

[i[Configuration-->Name and email]]

Bạn sẽ muốn làm điều này nếu, chẳng hạn, bạn có một số repo cho công việc và một số để vui chơi, hoặc nếu bạn có nhiều email công việc hoặc cá nhân muốn dùng trên từng repo riêng.

> **Mọi người, kể cả tôi, sẽ nói với bạn rằng bạn không nên dùng laptop công ty để làm việc cá nhân**, đặc biệt là khi "cá nhân" đó là làm thuê cho người khác. Dù vậy, các freelancer thường có nhiều việc cùng lúc (và họ sở hữu phần cứng của mình), và đôi khi người làm dự án cá nhân vì đam mê muốn dùng email khác nhau cho từng dự án.

Chúng ta đã đề cập điều này trong chương cấu hình, nhưng việc thay đổi identity cục bộ gắn với từng commit là khá đơn giản. Chỉ cần thay đổi `user.name` và `user.email` thành bất kỳ thứ gì bạn muốn.

Trong repo cần thay đổi, đặt cấu hình cục bộ để ghi đè cấu hình toàn cục của bạn:

``` {.default}
$ git config set user.name "My Alter Ego User Name"
$ git config set user.email "alterego@example.com"
```

Và sau đó khi bạn tạo commit trong repo này, identity đó sẽ được gắn vào chúng. Commit trong các repo khác vẫn tuân theo tên và email toàn cục của bạn (trừ khi bạn cũng đã ghi đè chúng).

## Thay Đổi SSH Authentication Key (Khóa Xác Thực SSH)

[i[Configuration-->SSH identity]<]

Bạn sẽ muốn làm điều này nếu bạn đang kết nối đến remote riêng tư của ai đó (ví dụ họ đang chạy site Gitea riêng), và bạn cần thiết lập SSH key khác chỉ để truy cập site đó. Nhưng bạn vẫn muốn dùng SSH key hiện tại cho GitHub cá nhân. Làm thế nào để dùng SSH key GitHub cho tất cả repo, và SSH key thay thế chỉ cho repo này?

Cách này phức tạp hơn một chút, và [fl[có một vài cách để làm điều này|https://superuser.com/questions/232373/how-to-tell-git-which-private-key-to-use]], nhưng tôi sẽ chia sẻ cách yêu thích của mình ở đây.

Trước tiên một chút nền tảng. Khi lệnh `ssh` chạy, nó cần biết đang chạy với identity nào. Nó dùng identity mặc định (trong file có tên `~/.ssh/id_something`, như `id_ed25519`) trừ khi bạn chỉ định cái khác.

Bạn có thể làm điều này trên dòng lệnh với switch `-i` của `ssh`.

Giả sử bạn có hai private key trong thư mục `.ssh`, `id_ed25519` và `id_alterego_ed25519`. Cái đầu là key mặc định SSH dùng. Nhưng nếu muốn dùng cái kia, chúng ta có thể chỉ định:

``` {.default}
$ ssh -i ~/.ssh/id_alterego_ed25519 example.com
```

Thừa nhận rằng gõ như vậy khá phiền, nên một số người thiết lập SSH config để dùng key cụ thể với hostname cụ thể. Nhưng chúng ta không đi theo hướng đó.

Thay vào đó, hãy bảo Git dùng một identity cụ thể bằng cách đặt biến `core.sshCommand` cục bộ cho repo này. Biến này chỉ chứa lệnh SSH mà Git dùng để kết nối, thường là `ssh`. Hãy ghi đè nó:

``` {.default}
$ git config set core.sshCommand \
    "ssh -i ~/.ssh/id_alterego_ed25519 -F none"
```

(Lệnh trên được chia thành hai dòng cho vừa lề trang---thực ra là một dòng và `\` là ký hiệu tiếp dòng của Bash.)

Và---khoan một chút---`-F none` kia là gì? Đó chỉ là một biện pháp an toàn bảo SSH bỏ qua file cấu hình mặc định của nó. Nhớ lại ở trên tôi đã nói người ta đôi khi đặt identity theo domain trong SSH config? Cái này sẽ ghi đè điều đó vì ghi đè chính là mục tiêu của chúng ta ở đây.

Lý do tôi thích cách này là bạn có thể dễ dàng làm trên từng repo, và cấu hình được lưu cùng repo (thay vì trong biến môi trường hay cấu hình SSH vốn không liên quan đến việc này).

[i[Configuration-->SSH identity]>]

## Thay Đổi GPG Signing Key (Khóa Ký GPG) {#gpg-signing}

[i[Configuration-->GPG signing key]<]

Nếu bạn dùng [fl[GPG key|https://www.gnupg.org/]] để ký, bạn có thể chỉ định key nào được dùng bằng cách lấy fingerprint của nó (hoặc email hay bất kỳ định danh duy nhất nào được GPG nhận ra).

Xin lỗi, việc thiết lập GPG keypair nằm ngoài phạm vi cuốn sách này. Nhưng thiết lập một lần từ phía Git trông như thế này:

``` {.default}
$ git config gpg.format gpg
$ git config commit.gpgsign true
```

Trước tiên hãy tìm secret key bạn muốn dùng:

``` {.default}
$ gpg --list-secret-keys --keyid-format LONG
  /user/.gnupg/pubring.kbx
  ------------------------------
  sec   rsa4096/0123456789ABCDEF 2022-01-01 [SC] [expires: 2025-01-
        9993456789ABCDEF0123456789ABCDEF01234567
  uid     [ultimate] Personal User Name <personal@example.com>
  ssb   rsa4096/9993456789ABCDEF 2022-01-01 [E] [expires: 2025-01-0
  sec   ed25519/ABCDEF0123456789 2022-01-01 [SC] [expires: 2025-01-
        FFFDEF0123456789ABCDEF0123456789ABCDEF01
  uid     [ultimate] Professional User Name <professional@example.c
  ssb   rsa4096/FFFDEF0123456789 2022-12-06 [E] [expires: 2024-12-0
```

(Output đã bị cắt bên phải để vừa trang sách.)

Hãy tìm identity bạn muốn dùng. Trong trường hợp này, giả sử chúng ta muốn dùng "Professional User Name". Chúng ta tìm dòng `sec` liên quan đến nó (ở trên), và sao chép phần sau kiểu mã hóa (thường là `rsa4096` hoặc `ed25519`). Ở đây là `ABCDEF0123456789` trong ví dụ tưởng tượng này.

Sau đó chúng ta cấu hình cục bộ cho repo này để dùng key đó.

``` {.default}
git config set user.signingkey ABCDEF0123456789
```

Sau đó khi bạn ký commit, key đó sẽ được dùng.

[i[Configuration-->GPG signing key]>]

## Thay Đổi SSH Signing Key (Khóa Ký SSH)

[i[Configuration-->SSH signing key]<]

Ngoài GPG, bạn cũng có thể ký commit bằng SSH key. Bạn có thể tạo signing key bằng `ssh-keygen`:

``` {.default}
$ ssh-keygen -t ed25519
```

Và sau đó bạn phải thực hiện một số cấu hình một lần nếu chưa làm. Dùng `--global` nếu bạn muốn thiết lập cho tất cả repo. Cái này bảo Git dùng SSH key và luôn ký commit:

``` {.default}
$ git config gpg.format ssh
$ git config commit.gpgsign true
``` 

Rồi chúng ta có thể đặt key dùng để ký. Thay đổi đường dẫn dưới đây để trỏ đến public key:

``` {.default}
$ git config user.signingkey ~/.ssh/id_ed25519_signing.pub
``` 

Cuối cùng, chúng ta phải thêm thông tin của bạn vào file `allowed_signers`. File này có thể đặt ở bất kỳ đâu; trong ví dụ này, chúng ta sẽ đặt nó trong `~/.ssh/`, nhưng bạn có thể đặt riêng từng repo nếu muốn.

Bước đầu tiên trong bước cuối cùng này là bảo Git biết `allowed_signers` của bạn ở đâu.

``` {.default}
$ git config gpg.ssh.allowedSignersFile "~/.ssh/allowed_signers"
```

Nội dung của file đó phải có ít nhất hai trường. Đầu tiên là địa chỉ email trong biến cấu hình `user.email` của bạn mà bạn sẽ dùng cho commit. Thứ hai là bản sao của public key từ biến `user.signingkey` của bạn. Lưu ý rằng bạn muốn *nội dung* của file đó, không phải tên file.

Ví dụ một dòng trong file `allowed_signers` trông như thế này (dòng đã bị cắt vì định dạng):

``` {.default}
user@example.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmaTS47vRmsKy
```

Bạn có thể có nhiều dòng trong file đó cho nhiều identity.

[i[Configuration-->SSH signing key]>]

[i[Identity]>]
