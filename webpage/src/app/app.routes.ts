import { Routes } from '@angular/router';
import { DashboardComponent } from './dashboard/dashboard';
import { Tickets } from './tickets/tickets';
import { LogsComponent } from './logs/logs';
import { KnowledgebaseComponent } from './knowledgebase/knowledgebase';

export const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'tickets', component: Tickets },
  { path: 'logs', component: LogsComponent },
  { path: 'kb', component: KnowledgebaseComponent },
];