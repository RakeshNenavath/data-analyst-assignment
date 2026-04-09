def remove_duplicates(text):
    result = ""
    for ch in text:
        if ch not in result:
            result += ch
    return result

print(remove_duplicates("programming"))  # Output: "progamin"
