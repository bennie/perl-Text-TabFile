use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Text::TabFile',
    'VERSION_FROM' => 'lib/Text/TabFile.pm',
    'PREREQ_PM'    => { Text::Delimited => 2.00 },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Text/TabFile.pm',
       AUTHOR     => 'Phillip Pollard <bennie@cpan.org>') : ()),
);
