async (clipboardContentString) => {
  let correctedText = clipboardContentString;
  correctedText = deleteInvalidLf(correctedText);
  correctedText = appendLF(correctedText);
  correctedText = deleteLeadWhiteSpace(correctedText);
  return correctedText;
};

let deleteInvalidLf = (txt) => {
  return txt.replace(/(\r?\n){1}(?!\r?\n)/g, "");
};
let appendLF = (txt) => {
  return txt.replace(/\.\s/g, "\n");
};
let deleteLeadWhiteSpace = (txt) => {
  return txt.replace(/\n\s+/g, "\n").replace(/(^\s+|\s+$)/, "");
};
