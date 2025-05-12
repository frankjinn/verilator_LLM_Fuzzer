import os
import re

def remove_comments(text):
    # Remove multi-line comments (/* ... */)
    text = re.sub(r'/\*[\s\S]*?\*/', '', text)
    
    # Remove single-line comments (// ...)
    text = re.sub(r'//.*?\n', '\n', text)
    
    # Remove empty lines and trailing whitespace
    text = '\n'.join(line.rstrip() for line in text.split('\n') if line.strip())
    
    return text + '\n'

def process_file(file_path):
    try:
        with open(file_path, 'r') as f:
            content = f.read()
            
        cleaned_content = remove_comments(content)
        
        with open(file_path, 'w') as f:
            f.write(cleaned_content)
            
        print(f"Processed: {file_path}")
        
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    seeds_dir = "potentialSeeds"
    
    # Get absolute path to potentialSeeds directory
    base_dir = os.path.dirname(os.path.abspath(__file__))
    seeds_path = os.path.join(base_dir, seeds_dir)
    
    if not os.path.exists(seeds_path):
        print(f"Directory not found: {seeds_path}")
        return
        
    # Process all .sv files in the directory
    for file_name in os.listdir(seeds_path):
        if file_name.endswith('.sv'):
            file_path = os.path.join(seeds_path, file_name)
            process_file(file_path)

if __name__ == "__main__":
    main()