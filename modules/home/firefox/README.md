enable toolkit.legacyUserProfileCustomizations.stylesheets in about:config if not already.


In 'Profile Directory' (Menu > Help > Troubleshooting Information > Profile Directory) create
folder chrome with file userChrome.css and other .css files.


see https://github.com/mbnuqw/sidebery/wiki/Firefox-Styles-Snippets-(via-userChrome.css)


Sidebery - Styles Editor
---
/*
#root {
  --tabs-font: 10pt Segoe UI;
  --tabs-count-font: .625rem Segoe UI;
  --bookmarks-bookmark-font: .875rem Segoe UI;
  --bookmarks-folder-font: 10pt Segoe UI;
}
*/

/* Adjust styles according to sidebar width */
@media screen and (max-width: 49px) {
  #root {
    --tabs-indent: unset;
  }
  .ScrollBox > .scroll-container {
    overflow: hidden;
  }
  .Tab .audio {
    left: 10px;
    transform: scale(.80);
    transform: translateY(4px);
    z-index: 99 !important;
  }
  .Tab .title {
    visibility: collapse;
  }
}
 
@media screen and (min-width: 49px) {
  .Tab .audio {
    left: 28px;
  }
}
 
/*
 * Add margins and rounding around tabs
 */ 
 
#root {
  --tabs-height: 43px;
}
 
/* Background layer */
 
.Tab {
  margin: 0 4px;
  width: unset;
}
.Tab .lvl-wrapper:after {
  content: '';
  position: absolute;
  top: 4px;
  width: 100%;
  height: calc(100% - 5px);
  border-radius: 4px;
  z-index: -1;
}
 
@media (prefers-color-scheme:light) {
  #root {
    --tabs-activated-bg: white !important;
    --tabs-bg-active: var(--tabs-activated-bg) !important;
    --tabs-selected-fg: var(--tabs-activated-fg) !important;
    --tabs-selected-bg: var(--tabs-activated-bg) !important;
    --bg: #f0f0f0 !important;
  }
  .Tab[data-selected] .lvl-wrapper:after,
  .Tab[data-active] .lvl-wrapper:after {
    box-shadow: 0 0 1px rgba(128,128,142,0.9), 0 0 4px rgba(128,128,142,0.5);
  }
}
 
 
/* Reset default styles */
.Tab:hover,
.Tab:active,
.Tab[data-active],
.Tab[data-active]:active,
.Tab[data-selected],
.Tab[data-selected]:hover,
.Tab[data-selected]:active {
  background: transparent;
}
 
/* Reapply styles */
 
.Tab:hover .lvl-wrapper:after {
  background-color: var(--tabs-bg-hover);
}
 
.Tab:active .lvl-wrapper:after,
.Tab[data-active]:active .lvl-wrapper:after {
  background-color: var(--tabs-bg-active);
}
 
.Tab[data-active] .lvl-wrapper:after {
  background-color: var(--tabs-activated-bg);
}
 
 
.Tab[data-selected] .lvl-wrapper:after {
  background-color: var(--tabs-selected-bg);,
}
 
/* Resize and reposition favicons */
.Tab .fav {
  width: 18px;
  height: 18px;
  margin-left: 10px;
}
 
.Tab .placeholder > svg {
  width: 18px;
  height: 18px;
}
 
.Tab .fav,
.Tab .placeholder,
.Tab .t-box {
  margin-bottom: -2px;
}

 
