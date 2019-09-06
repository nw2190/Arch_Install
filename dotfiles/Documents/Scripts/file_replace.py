from tempfile import mkstemp
from shutil import move
from os import fdopen, remove
import argparse


def replace(file_path, pattern, subst):
    #Create temp file
    fh, abs_path = mkstemp()
    with fdopen(fh,'w') as new_file:
        with open(file_path) as old_file:
            for line in old_file:
                new_file.write(line.replace(pattern, subst))
    #Remove original file
    remove(file_path)
    #Move new file
    move(abs_path, file_path)



def parse_args():
    desc = "Replace relative paths with absolute paths"
    parser = argparse.ArgumentParser(description=desc)

    parser.add_argument('--file', type=str, default='/home/nick/.tmp/',  help='File location')
    parser.add_argument('--search', type=str, default='./', help='String to find')
    parser.add_argument('--replace', type=str, default='/home/nick/.tmp/', help='String to replace matches')
    parser.add_argument('--add_slash', type=bool, default=False, help='Add trailing slash to replace string')
    
    return parser.parse_args()


"""main"""
def main():
    # parse arguments
    args = parse_args()
    if args is None:
      exit()

    #replace(args.file, './', args.pwd + '/')
    if args.add_slash:
        replace(args.file, args.search , args.replace + '/')
    else:
        replace(args.file, args.search , args.replace )

if __name__ == '__main__':
    main()
