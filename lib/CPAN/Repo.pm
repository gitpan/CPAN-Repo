package CPAN::Repo;
our $VERSION = '0.0.4';
1;

__END__

=head1 NAME

CPAN::Repo

=head1 SYNOPSIS

CPAN server for private cpan modules.


=head1 Usage

 Well, it's very simple!
 -----------------------
 
 1. make repository
 mkdir repo-root/repo-one
 
 2. copy distributives 
 cp Foo-v0.0.1.tar.gz Bar-v0.0.2 repo-one
 
 3. create cpan index 
 echo Foo-v0.0.1.tar.gz > repo-root/packages.txt
 echo Bar-v0.0.2 repo-one >> repo-root/packages.txt
  
 3. start cpan repo server
 cpan_repo repo-root/
 
 4. now all the modules are available to install via cpan plus client!
 cpanp
 %cpanp /cs --add http://127.0.0.1/repo-one/
 %cpanp x
 %cpanp i Foo


=head1 Features

 - simple maintenance - thanks to the author of CPANPLUS, custom sources idea is cool! for details see
 `CUSTOM MODULE SOURCES' section in http://search.cpan.org/perldoc?CPANPLUS::Backend
 - multiply cpan repos accessible via one cpan server, see datails below
 - index merge, see datails below
 - no need to care about global cpan mirrors synchronization as with CPAN::Mini, because in cpanplus
 they exist separately (as custom sources)


=head1 Multiple cpan repositoies

As with example above only one repository with private cpan modules was addes. What if you want more?
It's okay, just create as many as you wish, cpan repo server will care about further details:

 1 making repositories and copy distribuitves
 mkdir repo-root/repo-two
 mkdir repo-root/repo-three
 cp Baz-v0.0.1 repo-one repo-root/repo-two/
 cp Bazz-v0.0.1 repo-one repo-root/repo-three/
 
 
 2 re-setup cpanp client
 cpanp
 %cpanp /cs --remove http://127.0.0.1/repo/
 %cpanp /cs --add http://127.0.0.1/repo-one/repo-two/repo-three/
 %cpanp x
 
 3 all three repos are available via cpan server!
 
 cpanp -i Foo
 cpanp -i Baz
 cpanp -i Bazz

=head1 Index merge 

Here it's time to say about one great feature of CPAN::Repo called 'index merge', it simply means
that repos which added to cpan server are merged B<in order>. Let's say we have Module called Foo of version
v0.0.2 in repo `repo-one' and module with the same name but of version 0.0.1 in another repo `repo-two', 
what happen if one add both repositories to cpan server, first `repo-one' and second `repo-two'? 
The module from `last added' repo will win, and we'll get final version 0.0.1 of module Foo, this
is handled by cpan server and called index merge.

Here is great possibility for users:

 * Delevloper's "sandbox" cpan repos which may be merged with "trunk" cpan repository during development cycle.
 * Repos for patched modules coming from official cpan mirrors.
 * Repos with "frozen" versions of modules, allow to tag versions of your cpan modules and avoid installing 
 last version of module when it's inadmissible.
 
 The main idea here is an isolation of your private cpan modules and capability to merge arbitrary cpan repositories
 during deploment process.

=head1 Author

Alexey Melezhik / melezhik@gmail.com

=head1 See also

http://search.cpan.org/dist/CPANPLUS/
http://search.cpan.org/perldoc?CPAN::Mini

