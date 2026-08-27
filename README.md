# IceLand

IceLand は、Linux/Wayland 上で動作する **Dynamic Island 風のイベントハブ**です。Quickshell と Qt Quick を使い、通常は小さな時計として待機し、通知・音量・メディア・タイマー・ビルド進捗などが発生したときだけ滑らかに展開します。

このリポジトリには、Codex を中心に開発を進めるための初期基盤を含めています。

## 現在の土台

- Quickshell 0.3 系を使うマルチモニタ対応 `PanelWindow`
- 透明領域をクリック透過する入力マスク
- Idle / Activity / Expanded のモーフィングUI
- 優先度付きの汎用Activityコントローラー
- `qs ipc` から操作できるLive Activity API
- Qt Quick RHIのVulkanバックエンドを既定にしたNix devshell
- Codex向け `AGENTS.md`、repo-scoped Skills、custom subagents
- QML・Shell・Nixを確認するローカル検証とGitHub Actions

## 開発開始

Nix flakesを有効にしたLinux環境で実行します。

```bash
git clone https://github.com/keewai704/IceLand.git
cd IceLand
nix develop
just dev
```

`direnv` を使用する場合は次だけです。

```bash
direnv allow
just dev
```

初回は依存関係を固定するため、生成された `flake.lock` をコミットしてください。

```bash
just lock
```

## デモ

IceLandを起動したまま別のターミナルで実行します。

```bash
nix develop
just demo
```

直接IPCを呼ぶ例:

```bash
qs ipc call island ping
qs ipc call island showActivity demo "Building IceLand" "128 / 347" "✦" 0.37 5000 50 false
qs ipc call island updateProgress demo 0.72
qs ipc call island setExpanded true
qs ipc call island clearActivity demo
```

## 主なコマンド

```bash
just dev       # Vulkan RHIでIceLandを起動
just demo      # デモActivityを表示
just check     # QML / shell / Nixの静的検査
just format    # QML / shell / Nixを整形
just rhi-info  # Vulkan RHIとValidation Layerの情報を表示しながら起動
just lock      # flake.lockを更新
```

OpenGLへ切り替える場合:

```bash
QSG_RHI_BACKEND=opengl just dev
```

## 設計資料

- [`docs/PRODUCT.md`](docs/PRODUCT.md): 製品原則とActivity優先順位
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md): QMLモジュール、状態管理、性能設計
- [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md): 開発環境と検証方法
- [`docs/ROADMAP.md`](docs/ROADMAP.md): 機能の実装順
- [`docs/QML_STYLE.md`](docs/QML_STYLE.md): IceLand固有のQML規約
- [`AGENTS.md`](AGENTS.md): Codexが常に従うリポジトリ規約
- [`PLANS.md`](PLANS.md): 大きな変更で使う実行計画の形式
