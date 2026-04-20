# Hướng dẫn Git của Beej (Bản tiếng Việt)

> Tiếng Việt &middot; [English](README.en.md)

Bản dịch tiếng Việt của [Beej's Guide to Git][bggit], tác giả Brian
"Beej Jorgensen" Hall. Cuốn sách hướng dẫn Git từ cơ bản đến nâng cao:
từ commit đầu tiên, branching, merging, đến rebase, stash, submodule,
worktree, và các kỹ thuật nâng cao như cherry-pick, reflog, patch mode.
Đọc miễn phí, chia sẻ thoải mái.

[bggit]: https://beej.us/guide/bggit/

## Có hợp với tôi không?

Hợp nếu bạn đang học Git hoặc muốn hiểu sâu hơn những gì đang xảy ra
bên dưới. Không yêu cầu kiến thức lập trình---chỉ cần biết dùng terminal.

Nếu bạn đọc tiếng Anh thoải mái, cứ [đọc bản gốc][bggit].

## Bố cục repo

```
bggit-vi/
├── src/         # Bản gốc tiếng Anh (lấy từ upstream, không sửa)
├── src_vi/      # Bản dịch tiếng Việt (phần hay ho ở đây)
├── source/      # Chương trình mẫu (giữ nguyên từ upstream)
├── cover/       # Ảnh bìa
├── translations/# Các bản dịch ngôn ngữ khác có sẵn từ upstream
├── website/     # Tài nguyên website của upstream
├── scripts/     # Build helper, release helper
├── bgbspd/      # Submodule build system dùng chung của Beej
├── ROADMAP.md   # Kế hoạch và tiến độ dịch
├── UPSTREAM.md  # Đang bám upstream ở commit nào
├── LICENSE.md   # CC BY-NC-ND 4.0, giống upstream
└── README.md    # Bạn đang ở đây
```

## Tình trạng

CI/CD tạm tắt trong lúc marathon dịch diễn ra. Sau khi 38 chương
dịch xong, CI/CD bật lại và bản release đầu tiên được cắt.
Theo dõi tiến độ ở [ROADMAP.md](ROADMAP.md).

## Giấy phép

Nội dung gốc tiếng Anh thuộc bản quyền của Brian "Beej Jorgensen" Hall,
phát hành theo [CC BY-NC-ND 4.0][license]. Bản dịch cũng theo giấy phép đó.

[license]: https://creativecommons.org/licenses/by-nc-nd/4.0/
