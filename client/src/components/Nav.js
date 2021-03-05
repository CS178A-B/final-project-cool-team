import React from 'react';

import {
  EuiBreadcrumbs,
  EuiButton,
  EuiPageContent,
  EuiPageContentHeader,
  EuiPageContentHeaderSection,
  EuiTitle,
  EuiSpacer,
} from '@elastic/eui';

export default () => {
  const breadcrumbs = [
    {
      text: 'Home',
      href: '#',
      onClick: (e) => {
        e.preventDefault();
      },
      'data-test-subj': 'breadcrumbsAnimals',
    },
    {
      text: 'Search',
      href: '#',
      onClick: (e) => {
        e.preventDefault();
      },
    },
    {
      text: 'GitHub Repository',
      href: 'https://github.com/CS178A-B/final-project-cool-team',
      target: '_blank',
      onClick: (e) => {
        e.preventDefault();
      },
    }
  ];

  return (
    <EuiPageContent>
      <EuiBreadcrumbs
        breadcrumbs={breadcrumbs}
        truncate={false}
        aria-label="An example of EuiBreadcrumbs"
      />
      <EuiSpacer size="xs" />
      <EuiPageContentHeader>
        <EuiPageContentHeaderSection>
          <EuiTitle size="l">
            <h1>Boa constrictor</h1>
          </EuiTitle>
        </EuiPageContentHeaderSection>

        <EuiPageContentHeaderSection>
          <EuiButton>Cancel</EuiButton>
        </EuiPageContentHeaderSection>
      </EuiPageContentHeader>
    </EuiPageContent>
  );
};