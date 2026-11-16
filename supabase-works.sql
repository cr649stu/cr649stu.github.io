-- ============================================================
--  个人作品 · 后台管理用表
--  在 Supabase Dashboard → SQL Editor 里整段执行
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists public.works (
  id          uuid primary key default gen_random_uuid(),
  title       text not null,
  summary     text not null default '',
  tags        text[] not null default '{}',
  hard_note   text not null default '',
  demo_url    text not null default '',
  demo_label  text not null default '打开 →',
  source_url  text not null default '',
  wide        boolean not null default false,
  sort_index  integer not null default 0,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists works_sort_idx on public.works (sort_index);

-- 更新时间
create or replace function public.touch_works()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists works_touch on public.works;
create trigger works_touch before update on public.works
  for each row execute function public.touch_works();

-- 行级权限：所有人可读，登录用户可写
alter table public.works enable row level security;

drop policy if exists works_read on public.works;
create policy works_read on public.works
  for select using (true);

drop policy if exists works_insert on public.works;
create policy works_insert on public.works
  for insert to authenticated with check (true);

drop policy if exists works_update on public.works;
create policy works_update on public.works
  for update to authenticated using (true) with check (true);

drop policy if exists works_delete on public.works;
create policy works_delete on public.works
  for delete to authenticated using (true);

-- 初始数据：和现在网站上的七张卡一致
insert into public.works (title, summary, tags, hard_note, demo_url, demo_label, source_url, wide, sort_index)
select * from (values
  ('毕业之前 · 校园全栈站点',
   '把个人博客、问答社区与迷你商城合并成一个校园毕业主题站点，共用一套账号与导航。React + Express + SQLite，含 JWT 登录、Markdown 渲染与下单事务扣库存。',
   array['React 19','TypeScript','Express','SQLite'],
   '三个栏目共用一套账号与数据库，下单要在事务里扣库存。',
   'works-before-graduation.html', '打开可点原型 →',
   'https://github.com/CR649STU/campus-fullstack', true, 1),
  ('传奇抽卡 · 足球球员卡牌游戏',
   '301 名球员、367 张卡，传奇 / 史诗 / 精选 / 普通四种稀有度；每日赠券、答题得券，抽到的球员可以排进四种阵型。三百多张卡面全部由内嵌 SVG 绘制。',
   array['原生 JS','SVG 立绘','localStorage'],
   '367 张卡面全部由内嵌 SVG 现画，不依赖任何图片。',
   'works-gacha.html', '打开游戏 →',
   'https://github.com/CR649STU/football-pack', false, 2),
  ('社团活动管理 · 信息管理系统',
   '四张表（用户资料 / 社团 / 活动 / 报名）串起报名流程：同一活动同一人只能报一次，名额由触发器在数据库层拦截，普通学生与负责人的界面差异来自 RLS 行级权限。',
   array['Supabase','PostgreSQL','RLS','触发器'],
   '并发报名靠数据库触发器兜底，RLS 决定谁能看到什么。',
   'works-clubhub.html', '打开可点原型 →',
   'https://github.com/CR649STU/clubhub', false, 3),
  ('计时器 · 静态小工具',
   '开始、暂停、重置三个按钮，时分秒显示。单文件 HTML + CSS + 原生 JS，计时用时间戳而不是每秒累加，切到后台再回来依然准确。',
   array['HTML','CSS','原生 JS'],
   '用时间戳而不是每秒累加，切到后台再回来也不走样。',
   'works-timer.html', '打开计时器 →',
   '', false, 4),
  ('栖木书房 · 图书借阅管理',
   '零第三方依赖的图书借还系统：借出与归还在同一事务里修正库存，逾期清单按应还日期自动汇总，所有写操作进入审计日志。Python 标准库 + SQLite，零依赖，装好 Python 就能跑。',
   array['Python','SQLite','原生 JS','事务'],
   '借还与库存在同一事务里完成，逾期清单按日期自动汇总。',
   '', '', '', false, 5),
  ('青禾学籍 · 学生信息管理',
   '单文件前端配 Supabase 后端：Auth 登录、RLS 行级权限、触发器审计，Realtime 订阅让多人同时修改也能即时刷新，一份 SQL 脚本即可建库。',
   array['Supabase','PostgreSQL','RLS','单文件前端'],
   'RLS、触发器审计与 Realtime 三者配合。',
   '', '', '', false, 6),
  ('本站 · 个人主页',
   '你现在看的这个站：手写的 HTML 与 CSS，没有框架、没有构建步骤，托管在 GitHub Pages 上。',
   array['HTML','CSS','GitHub Pages'],
   '无框架、无构建，四个演示以内嵌窗口直接运行。',
   '', '', '', false, 7)
) as t(title, summary, tags, hard_note, demo_url, demo_label, source_url, wide, sort_index)
where not exists (select 1 from public.works);
