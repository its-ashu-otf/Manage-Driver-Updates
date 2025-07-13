# 🚫🔄 Manage Driver Updates

A powerful batch script to **enable or disable automatic driver updates** on **Windows 11**, including Home Edition. This tool is perfect for users—especially those with AMD GPUs—who want full control over Windows Update’s handling of drivers.

---

## ⚙️ Features

* ✅ **Enable/Disable** automatic driver updates via a menu-driven interface
* 🏠 **Works on all editions**, including **Windows Home**
* 🚫 Blocks Microsoft’s **driver metadata and update services**
* 📉 Prevents **hardware info telemetry** collection
* 💪 Useful for AMD users facing performance issues after auto updates
* 🛡️ Edits registry keys **safely** and **restores default settings** when needed

---

## 🚀 How to Run

> You must run the script with **administrator privileges**.

Paste the following in an **elevated PowerShell** window:

```powershell
irm https://raw.githubusercontent.com/its-ashu-otf/Manage-Automatic-Driver-Updates/refs/heads/main/run.ps1 | iex
```

---

## 🖼️ Screenshot

> Here’s how the script looks when executed:

<img width="1146" height="396" alt="image" src="https://github.com/user-attachments/assets/7c47f4c4-3784-48ef-9c75-8625b5c968bd" />

---

## 🧠 Why Use This?

Windows Update often installs generic or unstable drivers—especially for GPU and chipset components. This can result in:

* Screen flickering
* Audio dropouts
* System crashes after update
* Resetting custom driver settings

This tool gives you **granular control** over that behavior—without Group Policy Editor or third-party tools.

---

## 🔐 Safety & Compatibility

* No third-party dependencies
* Can be safely reverted with the **"Enable"** option
* Does not interfere with normal Windows security updates

---

## 📎 License

MIT License © [Ashu](https://github.com/its-ashu-otf)

---
