# Mergetool

[i[Mergetool]<]

Bạn có ghét tất cả những dấu `>>>>>`, `=====`, và `<<<<<` mà Git nhét vào file của bạn khi có xung đột merge không?

Nếu có, dùng _merge tool_ (công cụ merge) có thể là thứ bạn đang cần. Merge tool sẽ cho bạn một màn hình đồ họa hiển thị các thay đổi của bạn, các thay đổi xung đột, và kết quả mong muốn của merge. Và nó hiển thị theo dạng dễ hiểu.

> **Cá nhân tôi không thích merge tool.** Nghe có vẻ điên, nhưng để tôi giải thích. Khi bạn đang trong tình trạng xung đột merge, thứ duy nhất bạn phải làm là chỉnh sửa các file có dấu phân cách `=====` và làm cho chúng _Đúng_, nhớ không? Bạn phải chỉnh sửa file cho đến khi nó chính xác, gỡ bỏ những dấu phân cách đó khi đi.
>
> Chỉ có bạn và file, vậy thôi. Không có trung gian nào can thiệp vào nội dung. Và khi xong, thứ bạn có là câu trả lời cuối cùng.
>
> Nhưng merge tool bản chất là trung gian. Và chúng ta phải tin tưởng rằng chúng ta đang dùng chúng đúng cách để hoàn thành công việc. Và với tôi, dù đã dùng chúng có lẽ đúng cách, tôi vẫn cảm thấy phải kiểm tra thủ công kết quả để chắc chắn nó _Đúng_.
>
> Lợi ích tôi thấy là với merge tool bạn thường có chế độ xem side-by-side (hai bên cạnh nhau), thay vì chế độ xem trên-dưới bạn thực sự có khi chỉnh sửa file xung đột. Điều này có thể giúp merge tool dễ dùng hơn khi bạn có nhiều đoạn xung đột lớn trong một file.
>
> Nhưng trong thực tế, tôi không bao giờ dùng chúng. Cũng trong thực tế, *rất nhiều* người dùng chúng.

## Cách Hoạt Động Của Merge Tool

Merge tool hoạt động trên cơ sở từng file. Vì vậy khi bạn dùng nó, bạn đang dùng trên một file xung đột cụ thể.

Chúng đều có xu hướng hiển thị ít nhất ba panel (khung):

* Các thay đổi xung đột của bạn
* Các thay đổi xung đột của họ
* File kết quả _Đúng_

Và chúng đều có xu hướng có cùng các thao tác cốt lõi:

* **Đến xung đột tiếp theo**---tất cả panel sẽ chuyển đến xung đột tiếp theo.
* **Đến xung đột trước đó**
* **Chọn của bạn**---sao chép các thay đổi xung đột _của bạn_ vào kết quả cuối cùng, tức là các thay đổi của bạn là _Đúng_.
* **Chọn của họ**---sao chép các thay đổi xung đột _của họ_ vào kết quả cuối cùng, tức là các thay đổi của họ là _Đúng_.

Về cách dùng, đây là những gì chúng ta sẽ làm, giả sử merge tool bắt đầu từ xung đột đầu tiên khi khởi động:

1. Chọn "của bạn" hoặc "của họ" để giữ các thay đổi _Đúng_.
2. Đến xung đột tiếp theo.
3. Lặp lại từ Bước 1 cho đến khi tất cả xung đột được giải quyết.

Sau khi đã đi qua tất cả xung đột và chọn bên này hay bên kia, hãy đảm bảo kết quả cuối cùng là _Đúng_ rồi lưu/hoàn tất kết quả.

Merge tool sẽ đã stage kết quả cho bạn, sẵn sàng để commit và hoàn tất merge.

## Một Số Merge Tool Ví Dụ

Có rất nhiều, và tôi sẽ đưa vào một số link ở đây theo thứ tự bảng chữ cái. Đa nền tảng trừ khi có ghi chú khác.

* [fl[Araxis Merge|https://www.araxis.com/merge/index.en]]---Windows, Mac
* [fl[Beyond Compare|https://www.scootersoftware.com/]]
* [fl[Code Compare|https://www.devart.com/codecompare/]]---Windows
* [fl[KDiff3|https://invent.kde.org/sdk/kdiff3]]
* [fl[Meld|https://meldmerge.org/]]
* [fl[P4Merge|https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge]]
* [fl[Vimdiff|https://www.vim.org/]]
* [fl[WinMerge|https://winmerge.org/]]---Windows

Ngoài ra, các IDE như VS Code và IntelliJ thường có merge tool tích hợp sẵn hoạt động độc lập với Git (không cần cấu hình gì trong Git).

## Dùng Vimdiff Làm Merge Tool

[i[Mergetool-->With Vimdiff]<]

Chúng ta sẽ đi nhanh qua việc dùng Vimdiff làm merge tool vì nó bao quát tất cả các tình huống và có cấu hình khá phức tạp. Các công cụ của bên thứ ba khác (ngoại trừ VS Code và các IDE khác có chức năng này tích hợp) sẽ có cấu hình tương tự. Hãy tìm kiếm trên Internet để có cấu hình phù hợp cho các công cụ khác.

> **Đây không phải tutorial Vim.** Vì vậy tôi chỉ giả định bạn biết cách làm những việc như lưu file và thoát. Tôi sẽ nói rằng để chuyển cửa sổ trong Vim bạn dùng `CTRL-W` theo sau là hướng con trỏ, chẳng hạn `CTRL-W` theo sau là `h` để di chuyển đến cửa sổ bên trái.

Trước tiên, hãy thiết lập cấu hình.

``` {.default}
$ git config --global set merge.tool vimdiff
$ git config --global set mergetool.vimdiff.cmd \
                             'vimdiff "$LOCAL" "$REMOTE" "$MERGED"'
$ git config --global set difftool.vimdiff.cmd \
                             'vimdiff "$LOCAL" "$REMOTE"'
```

(Các lệnh dài được chia nhỏ để vừa lề trang---có thể viết trên một dòng.)

Lưu ý dòng cuối để thiết lập rõ ràng chế độ hai panel cho `vimdiff` và `difftool`. Nếu không đặt, chỉ thị `mergetool.vimdiff.cmd` sẽ khiến `difftool` hiển thị ba panel---có thể không phải thứ bạn muốn.

Khi đã có cấu hình đó, giả sử chúng ta có xung đột merge.

``` {.default}
$ git merge branch
  Auto-merging foo.txt
  CONFLICT (content): Merge conflict in foo.txt
  Automatic merge failed; fix conflicts and then commit the result.
```

Lúc này, chúng ta đang trong tình trạng xung đột merge bình thường.

``` {.default}
$ git status
  On branch main
  You have unmerged paths.
    (fix conflicts and run "git commit")
    (use "git merge --abort" to abort the merge)

  Unmerged paths:
    (use "git add <file>..." to mark resolution)
	  both modified:   foo.txt

  no changes added to commit (use "git add" and/or "git commit -a")
```

Nhưng vì chúng ta đã thiết lập merge tool, hãy dùng nó:

``` {.default}
$ git mergetool
```

> **Nếu Git đang hỏi bạn xem có thực sự muốn chạy merge tool không** (điều mà bạn có lẽ muốn vì vừa chạy `git mergetool`), bạn có thể tắt "tính năng" đó với lệnh config này:
>
> ``` {.default}
> $ git config --global set mergetool.prompt false
> ```
 
<!-- ` -->

Lệnh này sẽ mở một cửa sổ Vim với ba panel. Bên trái là các thay đổi cục bộ của bạn, ở giữa là file đang tồn tại trong repo, và bên phải là kết quả của merge.

Mục tiêu là làm cho cái bên phải trông _Đúng_. Bạn có thể làm trực tiếp bằng cách chỉnh sửa file ở đó, nhưng nếu vậy thì tại sao lại dùng merge tool?

Vì vậy chúng ta sẽ theo các bước đã phác thảo trước đó.

Khi lần đầu chạy `git mergetool`, chúng ta được đặt tại xung đột đầu tiên với con trỏ ở cửa sổ bên trái. Cửa sổ bên trái chứa các thay đổi chúng ta đã thực hiện.

Trong cửa sổ giữa, chúng ta sẽ thấy các thay đổi tương ứng trong repo.

Và trong cửa sổ bên phải, chúng ta thấy những gì sẽ được stage khi xong. Ngay lúc này ở cửa sổ bên phải, chúng ta thấy tất cả những dấu `=====` và `<<<<<`. Nhưng chúng ta sẽ thay đổi điều đó trong giây lát.

*Di chuyển con trỏ đến cửa sổ bên phải.* Đây là nơi hành động diễn ra.

Đảm bảo con trỏ ở trên một phần được đánh dấu (có thể sẽ có nhiều màu). Phần được đánh dấu này là thứ chúng ta sẽ thay thế.

Hãy chọn thay đổi nào cần dùng.

Nếu bạn muốn giữ các thay đổi của mình (và bỏ những thay đổi trong repo), dùng lệnh Vim này:

``` {.default}
:diffget LOCAL
```

Nếu bạn muốn bỏ các thay đổi của mình (và giữ những thay đổi trong repo), dùng lệnh này:

``` {.default}
:diffget REMOTE
```

Khi bạn chạy một trong hai lệnh đó, bạn sẽ thấy nội dung trong cửa sổ bên phải thay đổi theo ý muốn.

Sau đó bạn có thể đến xung đột tiếp theo với `]c`. (hoặc về trước với `[c`.)

Làm điều này cho đến khi cửa sổ bên phải _Đúng_. Lưu ý rằng bạn cũng có thể chỉnh sửa cửa sổ bên phải trực tiếp thoải mái.

Khi xong, lưu cửa sổ bên phải và thoát tất cả cửa sổ.

**Quan trọng** là ngay khi bạn thoát merge tool, Git sẽ stage bất cứ thứ gì bạn đã lưu trong cửa sổ ngoài cùng bên phải. Nếu bạn thoát quá sớm và có thứ được stage trước khi xong, dùng `git checkout --merge` với file đó để đưa nó ra khỏi stage và trở về trạng thái "both modified".

Nếu có nhiều file xung đột, Git sẽ mở merge tool lại để xử lý file tiếp theo.

Và khi xong, các thay đổi đã được thực hiện và bạn có thể hoàn tất merge bằng commit như thường.

Nhưng khoan---cái file `.orig` kia xuất hiện từ đâu? Đọc tiếp!

[i[Mergetool-->With Vimdiff]>]

## Sao Lưu Bản Gốc

[i[Mergetool-->File backups]]

Theo mặc định, khi dùng merge tool, Git sẽ giữ bản sao lưu của file trước khi merge tool chỉnh sửa nó. Bạn sẽ thấy chúng với phần mở rộng `.orig`, như thế này:

``` {.default}
foo.txt.orig
bar.txt.orig
```

Bạn có thể thêm chúng vào `.gitignore` nếu muốn, hoặc bạn có thể ngăn việc tạo ra chúng ngay từ đầu với biến cấu hình này:

``` {.default}
$ git config --global set mergetool.keepBackup false
```

[i[Mergetool]>]
