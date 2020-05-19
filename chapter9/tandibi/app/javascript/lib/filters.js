export function truncate(text, length) {
  const clamp = "..."
  if (text.length <= length) {
    return text
  } else {
    let subString = text.substr(0, length-1)
    let lastSpaceIdx = subString.lastIndexOf(' ')
    subString = subString.substr(0, lastSpaceIdx)
    return subString + clamp
  }
}
