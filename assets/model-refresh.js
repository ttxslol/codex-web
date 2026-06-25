const REFRESH_COMMAND = "/refresh-models";

function showRefreshStatus(message, kind = "info") {
  let status = document.querySelector("[data-codex-model-refresh-status]");
  if (!(status instanceof HTMLDivElement)) {
    status = document.createElement("div");
    status.dataset.codexModelRefreshStatus = "";
    Object.assign(status.style, {
      position: "fixed",
      top: "16px",
      left: "50%",
      zIndex: "2147483647",
      maxWidth: "min(560px, calc(100vw - 32px))",
      padding: "10px 14px",
      border: "1px solid color-mix(in srgb, currentColor 18%, transparent)",
      borderRadius: "12px",
      boxShadow: "0 8px 28px rgb(0 0 0 / 20%)",
      font: "500 13px/1.4 system-ui, sans-serif",
      transform: "translateX(-50%)",
    });
    document.body.append(status);
  }

  status.textContent = message;
  status.style.color = kind === "error" ? "#ffb4ab" : "inherit";
  status.style.background =
    kind === "error"
      ? "color-mix(in srgb, #7f1d1d 92%, transparent)"
      : "color-mix(in srgb, Canvas 94%, transparent)";
}

async function refreshModels() {
  showRefreshStatus("Refreshing Sub2API models…");

  try {
    const response = await fetch("/__backend/models/refresh", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-Codex-Model-Refresh": "1",
      },
      credentials: "same-origin",
      body: "{}",
    });
    const body = await response.json();
    if (!response.ok) {
      throw new Error(body?.error || `HTTP ${response.status}`);
    }

    showRefreshStatus(
      `Loaded ${body.models?.length ?? 0} models. Restarting Codex…`,
    );
    window.setTimeout(() => window.location.reload(), 4_000);
  } catch (error) {
    showRefreshStatus(
      `Model refresh failed: ${error instanceof Error ? error.message : String(error)}`,
      "error",
    );
  }
}

document.addEventListener(
  "keydown",
  (event) => {
    if (
      event.key !== "Enter" ||
      event.shiftKey ||
      event.isComposing ||
      event.repeat
    ) {
      return;
    }

    const target = event.target;
    if (!(target instanceof Element)) {
      return;
    }

    const editor = target.closest(
      '.ProseMirror[contenteditable="true"], [contenteditable="true"][role="textbox"]',
    );
    if (!(editor instanceof HTMLElement)) {
      return;
    }

    if (editor.innerText.trim() !== REFRESH_COMMAND) {
      return;
    }

    event.preventDefault();
    event.stopImmediatePropagation();
    void refreshModels();
  },
  true,
);
